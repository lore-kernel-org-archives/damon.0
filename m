Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5981B3943
	for <damon@lists.linux.dev>; Mon, 25 Nov 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559281; cv=none; b=Arrb1s4VqLgTmUsAhGqMJftXphO8Qks8ApDtk3HfifJXZeppUWiNE2eioAlROP2bGAvFg8UvzIdrjW+dhytm1vwzSXtn/NhQjLkGwa5oLeAmZ93/L19a7mbMiU8wOjwdn2u9NDDjSII6ZNWjd4+DVs+tQI2qC3deCiT2ZW4iwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559281; c=relaxed/simple;
	bh=zVlv7P6zsaB+m6wAPQslYHpuIly+tZmAlxG8ZgQsm8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JV2NCY8G8+GgWtXOBRIzCd6zoIkeg0twqDheOSUwZhI8fyPswJ6y2sZiVhnOBeWR3WVaq0usuQHvl+iQWdukNR88W9+htXPJeXNsENwicaIQAVU1Jd7FvGdiF3QgkB8EmN69GLIZ+TgqyPXORAjRui8EVhtCZM/i77p10kzEpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZsuXUwM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZsuXUwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8803C4CECE;
	Mon, 25 Nov 2024 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732559280;
	bh=zVlv7P6zsaB+m6wAPQslYHpuIly+tZmAlxG8ZgQsm8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZsuXUwM+ascRtqJHatbhYYS3/GuG6hyuTa8AAcc+sTvfLxMtPwuVSN4NQcZOQgC5
	 SWODJUqjNFV7yyRp1dL6cC/B5tYphwHQeYWBubgpmZFzh9OkC3tsxG7G12nuGtOEum
	 J9EMLBZMLkttOR45iKfhxikQoS59JASwwSqaCT2T58O+b6Tp5vxM0a4MaePPKXV1Vo
	 hZ/aNhfIGoAVehyQhABqwZ+MFa+xP6gDpw+zBtzZvByNBkmdd4wkG0e2COSu3ATkOR
	 o0yExQagNPUNm5MUU8mhfZCEDj7wDG03yJvq/Ux9a79hA/ieelsv4f+Ckr8g9mn/7n
	 QJF5F/m4uu+6Q==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel_team@skhynix.com
Subject: Re: [PATCH] mm/damon/core: Refactor damos_set_effective_quota
Date: Mon, 25 Nov 2024 10:27:56 -0800
Message-Id: <20241125182756.23921-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125044938.1412-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Nov 2024 13:49:33 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> On Fri, 22 Nov 2024 11:29:26 -0800 SeongJae Park <sj@kernel.org> wrote:
> > Hi Honggyu,
> > 
> > 
> > Thank you for this patch.  Definitely DAMON needs many refactoring and
> > cleanups.
> > 
> > The subject of the patch is a little bit ambiguous to me.  Could we make it
> > more specific, e.g., "set esz of damos_set_effective_quota() as ULONG_MAX by
> > default"?
> 
> Hi SeongJae,
> 
> Thanks for the review, but IMHO, setting the default value of esz is to remove
> one of duplicate if statement, not the goal of this patch.
> 
> So I think the following title might be better.
> 
>   mm/damon/core: remove duplicate list_empty quota->goals check
> 
> Is this okay for you?

Yes, this looks specific and non-ambiguous enough to me.

[...]
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -1542,7 +1542,7 @@ static unsigned long damos_quota_score(struct damos_quota *quota)
> > >  static void damos_set_effective_quota(struct damos_quota *quota)
> > >  {
> > >  	unsigned long throughput;
> > > -	unsigned long esz;
> > > +	unsigned long esz = UINT_MAX;
> > 
> > Let's use ULONG_MAX.
> 
> Ack. I will apply this and send v2 soon.

Thank you, I will review it soon :)


Thanks,
SJ

[...]

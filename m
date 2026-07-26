Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564A3E2ADD
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785092073; cv=none; b=G0BY+0lR2dpbaSbxteG7rOfjuLV+4JiPdai7ywQw3qYboX0/XDf4A1g7Cjo7MWSsN/eJbWrS/Zt7Y6P6eKRl8owFjFiakoNU/OF3XVS4IpRo1/cWjeT3ZlmvHiO1FRUOXopt26lTh9ufdZHpWNAUDDAddTJE3S0qI7tadSkeHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785092073; c=relaxed/simple;
	bh=gEct8+x01GRk4PNuXakrWf3d1kTG8ilHcq3QNHga0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngqBzVScvwK+pK47FN2cEzIK55aFYrrtpf0V4dQzQaslGZnMYMBmN8R7EkiVYjL74YBPBy7svFfHFLddZIClLIYqfFjoT387R/qI0/NhVpauNyyso30lSGf1OB0xmAlRHAgtNMUBEnr3WmdOIj26+595wwQkAtbPj22xf+gSOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1azyHgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1azyHgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13ABB1F000E9;
	Sun, 26 Jul 2026 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785092072;
	bh=5u0CoAmO3JjdmFLy7/0uUAoe9e7B8js9CqsIhsKiGNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O1azyHgW0GEdg20ZMS5zNYysG9+kXa6k4ODK91P09yCWM6ciTRqJXulajPlRnUlSg
	 l9GtNl/BwpBghG6WbPcOdbuhpKTW5V8B3VeigILnnjEWeBultSHly1LA3ppWawMK1h
	 OVXtKZud0FWCBfYyZArGkV4JZYQnRAcWHXJN9e94g/GoHaO0R8+z0El1wWoUXdb22v
	 N8hK6c35C4D9R/0gTf4B0AF9ZTe6plAI0GNkZ31pNrIXuMo7ggNyWqkhE+9Wk/016N
	 +S+1XKvwh64KNIuYCFYe46rBDljqGK6E31QWovA6RaK1jsP2He5HywrHQwZJZOJMgm
	 4qelKej8y23iw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directory
Date: Sun, 26 Jul 2026 11:54:22 -0700
Message-ID: <20260726185424.2152-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726174608.9C20E1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 17:46:08 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The kobj_type structure `damon_sysfs_preps_ktype` is missing the `static` keyword.
> --
> 
> --- Patch [9]: [RFC PATCH v2 09/17] mm/damon/sysfs: implement preps directory ---
> commit 8155aac7530c47520c4a221fb588dbd6e53e3875
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs: implement preps directory
>     
> This commit implements a sysfs directory and a file for setting DAMON probe
> preps. It introduces the preparatory data structures and functions without
> actually generating the directories yet.
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 50ff1c172d746..bf65e87fcb521 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> 
> [ ... ]
> 
> > @@ -750,6 +750,74 @@ static const struct kobj_type damon_sysfs_intervals_ktype = {
> >  	.default_groups = damon_sysfs_intervals_groups,
> >  };
> >  
> 
> [ ... ]
> 
> > +static struct attribute *damon_sysfs_preps_attrs[] = {
> > +	&damon_sysfs_preps_nr_attr.attr,
> > +	NULL,
> > +};
> > +ATTRIBUTE_GROUPS(damon_sysfs_preps);
> > +
> > +const struct kobj_type damon_sysfs_preps_ktype = {
> [Severity: Low]
> Does this inadvertently expose damon_sysfs_preps_ktype to the global
> namespace?
> 
> It looks like the static keyword is missing on the definition of
> damon_sysfs_preps_ktype, which will cause it to be globally visible and may
> trigger static analysis warnings.

This is an intended thing, for not causing build warning, while splitting
change in reviewable size.

> 
> > +	.release = damon_sysfs_preps_release,
> > +	.sysfs_ops = &kobj_sysfs_ops,
> > +	.default_groups = damon_sysfs_preps_groups,
> > +};
> > +
> >  /*
> >   * filter directory
> >   */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260726173935.94046-1-sj@kernel.org?part=9


Thanks,
SJ

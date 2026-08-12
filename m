Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0F2FFF8B;
	Wed, 12 Aug 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504063; cv=none; b=skRw4cBdSjI41lN9bmAvLVTM8Raz8yOfckYlb0L4DZp9RlyKeDV3vQKxD01paOl7YsbsI7taUR7UXICxjQ9VNgINxPm2xh1F96OAN/9AKAXKy21FbD8MvA9zAPBaPc85l1xGpBW5uFja1rmVmP/POvEBenLwO2jXken6AXgHHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504063; c=relaxed/simple;
	bh=XpB+TXMpKQKjG+vXtskddblr3q1MOV03pLLvnPYtorw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECf4Z0QkR8lgRhtK+2IRZnYEPlnHJd/6lXfhQLVO2huirBY9ycgFnYNWH9yUaYRlnAixhnxC6m6qfQBfZvi/NB7J3Re2wDwJTfjJjbA5U/ahPHF2R+Nvq0o7LPTN9PeIHVjCPPbf31cHr7JKdyH820j8+53rZCRpnHirJuJ9/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpztcKOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpztcKOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AD91F000E9;
	Wed, 12 Aug 2026 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786504062;
	bh=pJkuoHatQ+SArs9G28f8aRqkTwBhTBoxrzbmBbZkkvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YpztcKOVjRom60I76BQWeohbn/0zBZyukjnb3kaH6nCXUminVx9EEEcvQrZ8uRCpb
	 Ba7pff9vTGbo34dPmNrGj1L+ub/VeQHFxyXu9p502xxysPfBVmiSKpvBSghKlI729w
	 RW++PavfS4RszBXHLNieQNTbuX+YtjQdxgthY/ljsPbPKvTiKnB3cLWcSsiq9vXz8y
	 c1WNvndAFNkIVtbB9HfDYo2NQbDDWFgdDCGb0dgFYLbXzI6gAt4kifeBqYCjh99PPb
	 CYr2a5W4vol6kVaur3Brp4lRIm0Sasrd8goPdeX6KyXfd2PwTqla2SyopB3YNsZJrx
	 lSWyRIcQ7Hseg==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	damon@lists.linux.dev,
	david@kernel.org,
	liam@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	skhan@linuxfoundation.org,
	surenb@google.com,
	vbabka@kernel.org
Subject: Re: [PATCH 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Tue, 11 Aug 2026 20:07:32 -0700
Message-ID: <20260812030733.8996-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260811170252.32705-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026 01:02:52 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> Hi SJ,
> 
> 
> On Tue, 11 Aug 2026 06:56:53 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > Hi Liew,
> > 
> > 
> > 'hkml patch check' [1] says you forgot Cc-ing below people who are recommended
> > by get_maintainer.pl.  Please Cc all recipients who
> > get_maitnainer.pl is recommending, from the next time.  'hkml patch format' [2]
> > could also help you doing so.
> > 
> 
> Thank you for reminding me! I will CC all email addresses output by
> get_maitnainer.pl from the next time.
> 
> > [...]
> >
> > On Tue, 11 Aug 2026 18:18:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Add an explanation of nr_snapshots to avoid misunderstandings.
> > 
> > Thank you for this patch series, Liew.
> > 
> > > 
> > > Liew Rui Yan (3):
> > >   docs/mm/damon/design: accurate semantics of nr_snapshots
> > >   docs/mm/damon/design: difference between watermarks and nr_snapshots
> > >   docs/mm/damon/design: fix typo of max_nr_snapshots
> > 
> > I requested changes to patches 1 and 2 via replies.
> 
> I will make changes in the next revision:
> 
> patch-1: "tried to be __completely applied__" -> "__completely tried__
> to be applied".
> 
> patch-2: use two spaces between sentences.

Sounds good!

> 
> > 
> > [1] https://github.com/sjp38/hackermail/blob/master/USAGE.md#checking-patches
> > [2] https://github.com/sjp38/hackermail/blob/master/USAGE.md#formatting-patches
> 
> 
> Best regards,
> Rui Yan


Thanks,
SJ

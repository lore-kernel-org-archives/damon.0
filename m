Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D51A9F90
	for <damon@lists.linux.dev>; Wed, 15 Apr 2026 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776213331; cv=none; b=qxrDBqkvw58DRLFl3WrFWdI4TP7ykhlA1UT6o3Csw3e4xHqEj7559C3upLQMp31C/ZNoqG7AAFsghphpoWWauv7IyoHmyBL7CmUBy2q+vTXV8WcuxSFxaW7P0rW3tVnm6wL3O1hjTt8Si1+B+NCzWiwc5rFzyUnkhriNciCNdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776213331; c=relaxed/simple;
	bh=CAJCp9WN4Nb65bF5MIDv0BKSwXNIavNcob2prXVnAoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN22wTS55yKRV4bw3rLRVpe42Yjii2afYYitmpzU6uM7S7gTZjD7g2xSDPYnUClg2cHxnFqQBZ819RsG799s9V75CQGY4ejBFezPBAG7PPC+MhrG6nSGz6WkkRw7/34qdgaLF5gLlxYvviEnSa13sRlLoGOHm9hGU3r+1CtS2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhtYuHvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhtYuHvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C86C19425;
	Wed, 15 Apr 2026 00:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776213331;
	bh=CAJCp9WN4Nb65bF5MIDv0BKSwXNIavNcob2prXVnAoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhtYuHvHVu6x/2ePrWD6RJC2gp6O9z6JZN+lBgLEvKGRc0l3hcx8UZfKkIj1KtCby
	 K7Sq1fRMOrLo9D16Obt1liviUyCjo7qjj3ie+UL8AkerwcmynCd+thA9x8/pC1xug1
	 LDkCtI/mqYP6wnwoVUFHIpdSMuMpwJ3YaEkMYdfK67MATs73fgjX/L+RqiozxPr7ZG
	 UB416G3kvBoSWIVn27qKlFc41mGSOoubRb3J9c0qkyOja8JeUP7ApKoZe1c73KvpTm
	 oypyt/49s3OD177T+RFSE4+JDTBTWzaGEE/WYF3/8J5qjmJTmU4+0aj77Iqr17T/3f
	 gj05hoQWqYjjQ==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v1.1 1/2] mm/damon/stat: add a parameter for reading kdamond pid
Date: Tue, 14 Apr 2026 17:35:23 -0700
Message-ID: <20260415003523.103888-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415001614.9C571C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 15 Apr 2026 00:16:14 +0000 sashiko-bot@kernel.org wrote:

> Sashiko AI review found 1 potential issue(s):
> - [Low] Missing closing brace `}` in `damon_stat_start()` error path causes compilation failure.
> --
> 
> commit 04b7136ae6b7cd907673996f57f0a613de1984b9
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: add a parameter for reading kdamond pid
> 
> This commit exposes the pid of the DAMON_STAT kdamond via a new read-only
> module parameter named kdamond_pid to help user-space management and
> monitoring.
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> 
> [ ... ]
> 
> > @@ -260,6 +269,13 @@ static int damon_stat_start(void)
> >  		damon_stat_context = NULL;
> >  		return err;
> >  	}
> > +	kdamond_pid = damon_kdamond_pid(damon_stat_context);
> > +	if (kdamond_pid < 0) {
> > +		err = kdamond_pid;
> > +		kdamond_pid = -1;
> > +		damon_destroy_ctx(damon_stat_context);
> > +		damon_stat_context = NULL;
> > +		return err;
> 
> Is there a missing closing brace for the if (kdamond_pid < 0) block here?
> It looks like the omission will swallow the rest of the function into the
> error path and cause a compilation failure.

Good eye.  I will fix this in the next revision.


Thanks,
SJ

[...]

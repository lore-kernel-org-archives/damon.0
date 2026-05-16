Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480E386C36
	for <damon@lists.linux.dev>; Sat, 16 May 2026 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969563; cv=none; b=B1EOUDtX27ChxgRjlOP0S7AoOdJqdvKh46Wy2PKDxBl8zo40O7avHm2dk0LPJhJabV7gKwxh9s4c+2zjsC4ThwSpMli6xEOWupFzaPZRXDSvvtcXw5X4n4OH5dj2V7pn2dTJLMvCwbb9pIUBb6S09jberWP7h+9Vg1WjjGduW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969563; c=relaxed/simple;
	bh=yGrbL0nsyYDONWU2QcZPYVudZ1oeLwMEmKD+rgA4S3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT7L8ZkTXlZcrLpBQjmILx6o5V3ZwjUhyHIqPCwDQwmBwlnxztevTwlCERMWTd3dca0W4FQvJlLuKDoIrPqD+FZ/yIEcUlUhAjkyY8hpZi9PNg9hiqUNZHNndSF/+2kOtosqqOjYH5DfYp1Ygd7UNjGMTEqW3sSYdToTUH4xVeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQCYMYaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQCYMYaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C5BC19425;
	Sat, 16 May 2026 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778969562;
	bh=yGrbL0nsyYDONWU2QcZPYVudZ1oeLwMEmKD+rgA4S3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQCYMYaES5nQ2RqE86exk32AxJU/CpncMaDEsm5GIqO2QEBDPWIiieiq8/7UiXd3T
	 nsjmJv0w8Uhv7qRRP8tIYIl5G8chCWDfdygykCXWFfsHBp5oXyM1K+dX0IIM/vbGQv
	 lsiY2wti/m0HfG4BAygxVVm2KbyDpgpFQCTtzI3VLZviyf9OBRuI+HCQmhepGzNQjR
	 GaQftkkVylt6zaMfgeglVT5vDUcJM3rWM8P9Q3X91VEX/dKRHQigef5lLqWxCobAZT
	 PD0WbNOiu/r57FaDvEDvsHqfPxqQ8dJopRpCf78kvr+V/u7RtcIX+tlaldqslgyNLo
	 RLcZZa9/hHKiw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
Date: Sat, 16 May 2026 15:12:34 -0700
Message-ID: <20260516221235.4589-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516213959.28859C19425@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 16 May 2026 21:39:58 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Moving `list_del()` out of the kobject release callback causes a Use-After-Free when `kobject_init_and_add()` fails in `damos_sysfs_populate_region_dir()`.
> --
> 
> commit 97136b36d31f71cb6972114db84fe86abd95246f
> Author: SeongJae Park <sj@kernel.org>
> Subject: mm/damon/sysfs-schemes: delete tried region in regions_rmdirs()
> 
> DAMON sysfs maintains the DAMOS tried region directory objects via a
> linked list. When the user requests refresh of the directories, DAMON
> sysfs removes all the region directories first, and then generate
> updated regions directory on the empty space. Deletion of the container
> region object from the linked list is now done inside the removal function
> instead of the kobj release callback.
> 
> [1] https://lore.kernel.org/20260513011920.119183-1-sj@kernel.org
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 622c3799db87b..aefeb5d22fb7d 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -88,7 +88,6 @@ static void damon_sysfs_scheme_region_release(struct kobject *kobj)
> >  	struct damon_sysfs_scheme_region *region = container_of(kobj,
> >  			struct damon_sysfs_scheme_region, kobj);
> >  
> > -	list_del(&region->list);
> >  	kfree(region);
> >  }
> 
> Does removing list_del() here cause a use-after-free if kobject_init_and_add()
> fails in damos_sysfs_populate_region_dir()?
> 
> If kobject_init_and_add() fails, the error path drops the reference:
> 
> mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir() {
>     ...
> 	list_add_tail(&region->list, &sysfs_regions->regions_list);
> 	sysfs_regions->nr_regions++;
> 	if (kobject_init_and_add(&region->kobj,
> 				&damon_sysfs_scheme_region_ktype,
> 				&sysfs_regions->kobj, "%d",
> 				sysfs_regions->nr_regions++)) {
> 		kobject_put(&region->kobj);
> 	}
>     ...
> }
> 
> Because region is added to the list before kobject_init_and_add(), dropping
> the reference will free the region, but it remains in regions_list since
> the release callback no longer unlinks it.

Good finding.  I wrote this patch on a tree having the data attributes
monitoring, which moved the list_add_tail() call to be done after
kobject_init_and_add() success, so missed this.

> 
> Should we add an explicit list_del(&region->list) in the error path of
> damos_sysfs_populate_region_dir() to prevent list corruption?

I will move list_add_tail() call to be done after kobject_init_and_add()
success.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260516211436.1883-1-sj@kernel.org?part=1


Thanks,
SJ

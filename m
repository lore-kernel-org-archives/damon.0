Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E1E2628D
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781654538; cv=none; b=PoLWaWzNF3VwKaxpuyCYhc8eipN/OTF3pnXU/tm7LI77Bo8TF9kH6TsVZ9+VqbvqdUhtwGPVIEPvWGp0EdxW5teOn5x/EGYNEhZs/gzPREtA/R1k+QCvhFIC9i2OXAkntddt/ant0/jX5KSg0cPzvjHBYe7I4uS4/x6hiVM1bb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781654538; c=relaxed/simple;
	bh=8Ecf7fdyq9O9CgaElztU5neyuka1YxhlepLvWG0T1ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvGJpsLANHwjOcmOcoiSG+J4s4/apeHcOyRXp1gm8mzbbsqnHTxS4aRQTRP1gjAJt9P409SXaPGBY6ucub5pUmMdQXkEeSuXM6ab9srDAYLv7Ou2JUWX8Hc+t8jmWemRr4ZbfWa00lIbo12Bp5gejIFCx8DNFU11ZFTWFBwkhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt5XYjuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt5XYjuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63341F000E9;
	Wed, 17 Jun 2026 00:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781654537;
	bh=Y8GR55rYy2/Flw4HzSEhWAm5Ca0Y4EPJdACybVwXqAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nt5XYjuBL6FN6EetW9QMS8jhTqtUVQ7iNfx0S8o0g9RvZjFVsvAqMlFysJ9K+Ews0
	 9VFBxfZvAAA37H6B0RA22eXM6W5A9ZGbp8PnYLYCXhyYMuKioJzLk8roBa5i9D2bV6
	 kpYI2WOH+Ru/ycxg3mhjzuNRKA8QjwDnRbFbaVMicxEYwX+v9m0fu5i6LIeBwPWMRT
	 WKT1A1TESSX5yOxlVe9/RNgNzlXMFEV+oj8uSDozfboH9uWa2teVlugn7l7GkC3eZV
	 +2UwQqgdLwM07MZG4pyq+J7vqkk0kFTw5f6SVB/vtWhi8T+Mmhmu0r51MYPZ4Ue2xV
	 nZMl6RosjDdtw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/9] mm/damon/sysfs: kobject_del() target, context and kdamond dirs
Date: Tue, 16 Jun 2026 17:02:08 -0700
Message-ID: <20260617000209.91653-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152553.C97A01F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:25:52 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete fix: Missing kobject_del() in sysfs directory creation error paths leads to persistent -EEXIST collisions.
> --
> 
> commit 1c0329e17860c383f4ab90a119f917db75ecacee
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs: kobject_del() target, context and kdamond dirs
> 
> On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
> could cause directories creation failures due to the name conflicts.
> Fix those issues for target, context and kdamond directories by adding
> kobject_del() calls.
> 
> Fixes: c951cd3b8901 ("mm/damon: implement a minimal stub for sysfs-based DAMON interface")
> Cc: <stable@vger.kernel.org> # 5.18.x
> 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index 2e95e3bac774d..d93f7919c3ca1 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -333,6 +333,7 @@ static void damon_sysfs_targets_rm_dirs(struct damon_sysfs_targets *targets)
> >  
> >  	for (i = 0; i < targets->nr; i++) {
> >  		damon_sysfs_target_rm_dirs(targets_arr[i]);
> > +		kobject_del(&targets_arr[i]->kobj);
> 
> [Severity: High]
> This isn't a regression introduced by this patch, but while you are fixing
> the -EEXIST name collisions in the rm_dirs() paths, are the same
> kobject_del() calls also needed in the error paths of the corresponding
> add_dirs() functions?
> 
> For example, in damon_sysfs_targets_add_dirs():
> 
>     mm/damon/sysfs.c:damon_sysfs_targets_add_dirs() {
>         ...
>             err = kobject_init_and_add(&target->kobj, ...);
>             if (err)
>                 goto out;
> 
>             err = damon_sysfs_target_add_dirs(target);
>             if (err)
>                 goto out;
>         ...
>     out:
>         damon_sysfs_targets_rm_dirs(targets);
>         kobject_put(&target->kobj);
>         return err;
>     }
> 
> If damon_sysfs_target_add_dirs() fails, kobject_put() is called without
> kobject_del(). Does this result in a lingering directory and a persistent
> -EEXIST if the user retries?
> 
> Similarly, in mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir():
> 
>     mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir() {
>         ...
>         if (kobject_init_and_add(&region->kobj,
>                     &damon_sysfs_scheme_region_ktype,
>                     &sysfs_regions->kobj, "%d",
>                     sysfs_regions->nr_regions))
>             goto out;
>         if (damos_sysfs_region_add_dirs(region, ctx, r))
>             goto out;
>         ...
>         sysfs_regions->nr_regions++;
>         return;
> 
>     out:
>         kobject_put(&region->kobj);
>     }
> 
> If this fails, it returns without incrementing sysfs_regions->nr_regions.
> Could the next region processed in the loop then attempt to initialize with
> the exact same name string, immediately hitting -EEXIST and breaking the
> entire region population loop?

Good finding.  I will fix this in the next revision, like below:

'''
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -374,13 +374,15 @@ static int damon_sysfs_targets_add_dirs(struct damon_sysfs_targets *targets,

                err = damon_sysfs_target_add_dirs(target);
                if (err)
-                       goto out;
+                       goto del_out;

                targets_arr[i] = target;
                targets->nr++;
        }
        return 0;

+del_out:
+       kobject_del(&target->kobj);
 out:
        damon_sysfs_targets_rm_dirs(targets);
        kobject_put(&target->kobj);
'''


Thanks,
SJ

[...]

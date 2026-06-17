Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B6134CF
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781657725; cv=none; b=VWDZ7btV9sVROedfdCocxmIkwu59tCDhG9bu6QsB3sqL0dgxluRNV8YOWG96pYsGsxV2rndXidlUo4C5vxQTL4hcB+Jg/Y6MDRN9U+7WDg1t2pVfz3eYhcyTSYn8jqK+4xf6MX+c9awHGrj319FYETgGOXkr7yTEnrljXI23/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781657725; c=relaxed/simple;
	bh=KzfqYDKmsPmZG+jkSp3yzM6yFiplYGNkSF197+sfgdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErfeAjcG7wIWQ5ZY1JMVMAwehykWK7Uc/7Kd3l4ZVAi2aS9ZJHo+4Xl0hkbVAjPcyYBiLCC1tfT6Gyqqn20PnRJW9Q03TmGk1Je2N3OG1lGZBR9Oy8ma5EaoTKZwDXshEhRCke1NtJ7Oz0dNtYIKyk/KotLB0HFivcBDRVcjZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofD1ZRFx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofD1ZRFx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFE21F000E9;
	Wed, 17 Jun 2026 00:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781657723;
	bh=S0wqx9yawqCinNmE+i1t/nAl5J0dbsL012XRlY8S/oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofD1ZRFxJpz1GxBpPNnVTjNpAz7Ph4Xxh6oTPnyVCMJaUhbf+Rc06UG5TADd/1Stb
	 Gbq0AUc2yF4pzmlu/YUZExdEIK3Ahnnngg7QoYeP4Vwf4xGRSy3/gF0vHVx39dlyRS
	 7SsBqMZ0F1FpKmTQPBoQASxQe+qgoTKHuOz4/BFWitbTEjQL2EGujKVJmOaA5rYCdU
	 RHko1VnQkHwxQjTVgzh9M7iHUTCGVZ2FBSTtoIKKWqIJGJoKPkNO9vFaWGcGYtbDJV
	 dKe5JRIcPJ946cvalSOnkyOKVrTNjRXLm+vMcACIm/lBG0Gy4+60mHEXCxOwDX0OZO
	 eZIOtHQzQjX4w==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 6/9] mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
Date: Tue, 16 Jun 2026 17:55:07 -0700
Message-ID: <20260617005507.96990-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260616152729.369181F00A3D@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jun 2026 15:27:28 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing Kobject Deletion on Error Path
> --
> 
> commit b01a934762aa810a11a4a01efdd70c41f7274410
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
> 
> This commit adds missing kobject_del() calls to the cleanup of scheme quota
> goal directories. This prevents directory creation failures due to name
> conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 300930c2c5b3f..737638be84f15 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> > @@ -1465,8 +1465,10 @@ static void damos_sysfs_quota_goals_rm_dirs(
> >  	struct damos_sysfs_quota_goal **goals_arr = goals->goals_arr;
> >  	int i;
> >  
> > -	for (i = 0; i < goals->nr; i++)
> > +	for (i = 0; i < goals->nr; i++) {
> > +		kobject_del(&goals_arr[i]->kobj);
> >  		kobject_put(&goals_arr[i]->kobj);
> > +	}
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since you are fixing missing
> kobject_del() calls here to prevent name collisions, do the error paths in the
> various *_add_dirs() functions need similar fixes?
> 
> If an error occurs after a successful kobject_init_and_add(), the error paths
> currently call kobject_put() without kobject_del(). This can leave the sysfs
> directory present until the object's reference count drops to zero and the
> delayed release runs, potentially causing a -EEXIST failure if a user retries
> the operation.
> 
> For example, looking at damon_sysfs_targets_add_dirs() in mm/damon/sysfs.c:
> 
>     err = damon_sysfs_target_add_dirs(target);
>     if (err)
>         goto out;
>     ...
> out:
>     damon_sysfs_targets_rm_dirs(targets);
>     kobject_put(&target->kobj);
>     return err;
> 
> Could this leak the sysfs directory for target->kobj? 
> 
> The identical pattern appears in several other error paths:
> - damon_sysfs_contexts_add_dirs() in mm/damon/sysfs.c
> - damon_sysfs_kdamonds_add_dirs() in mm/damon/sysfs.c
> - damon_sysfs_schemes_add_dirs() in mm/damon/sysfs-schemes.c
> - damos_sysfs_populate_region_dir() in mm/damon/sysfs-schemes.c

Good finding but Sashiko reported this in another reply to this thread, and I
promised to fix those in the next revision.


Thanks,
SJ

[...]

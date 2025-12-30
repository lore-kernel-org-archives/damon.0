Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2762322068D;
	Tue, 30 Dec 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767076710; cv=none; b=UiXzUZHq+YZObBXBL5YEJvShXmGNMeu7SjpwjJRcsgYAyvpXOu8Z4xR/NvpSQpm1EIaF2WXg4Luqahiod8SslaRqjX0bP8NYv1ktzHltauCvu6rzMSzCLbg+noW//cjbYZZwu5NASvu2gKYbxob2WyZ6oOuwzs98jynz9iGK3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767076710; c=relaxed/simple;
	bh=eowp0p4gKT3VPrW68XVjLuPtEfmIs83wpmHnaoFJ9/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwMr83tMHZnOw1lOxwMXEpFoao1U7ZAW33iORhSTyOUnOblSVtgr0SYPPvHqhGwe6BtVBODwPcX87kmRe+v56cFh7m7x3jqUw/GE3TABaokQFeW/qGhgqkK4tZfHhRpdsTg49OQX6LajgaIlAinCI2iMnmNb19CaIehmPTSf8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ7rsdDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ7rsdDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B57C4CEFB;
	Tue, 30 Dec 2025 06:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767076709;
	bh=eowp0p4gKT3VPrW68XVjLuPtEfmIs83wpmHnaoFJ9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZ7rsdDXz2+Y7gfKo2/hPuKDEeNDivNvp44OObhLDNaUj35y9pyeiEfdWKCL/V6k6
	 kVOQLR+CVFOMzcMagDGTZZfi97gDM2rgsEn+WRdey0fiCGpA4As50ZY0/PFr+JRe+M
	 IaBdQtB/94mVslWYyJGfEv0alkhcj/6U8ic+1+iV3qMRYjQlnltoycD1mgl4MdGQXZ
	 FHI8VB2z1T+0Sgj2h3Er21eoHkiad0pQ5LCr7hZgXGgMWOdFI7W99wSCmfiVcWn0W8
	 gYk/EpH4JMfjVsKKtPlSK7lDcsS1rl76I05cjwDJxysojcmob0j1bLiBAylESKAqeM
	 u1TFfzEx6iqFw==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 39/109] mm/damon/sysfs.c:920 damon_sysfs_sample_add_dirs() warn: missing error code 'err'
Date: Mon, 29 Dec 2025 22:37:58 -0800
Message-ID: <20251230063759.98547-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202512271918.xuSlfGd4-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Dec 2025 19:50:14 +0800 kernel test robot <lkp@intel.com> wrote:

> BCC: lkp@intel.com
> CC: oe-kbuild-all@lists.linux.dev
> TO: SeongJae Park <sj@kernel.org>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   1d3e0ce41f6d1140a6ca73d505b536f2edc92e40
> commit: 4cba4bd330b3be68e2624d824965554e1ba6a48c [39/109] mm/damon/sysfs: implement sample/filters/ directory
> :::::: branch date: 16 hours ago
> :::::: commit date: 2 days ago
> config: x86_64-randconfig-161-20251227 (https://download.01.org/0day-ci/archive/20251227/202512271918.xuSlfGd4-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202512271918.xuSlfGd4-lkp@intel.com/
> 
> smatch warnings:
> mm/damon/sysfs.c:920 damon_sysfs_sample_add_dirs() warn: missing error code 'err'
> 
> vim +/err +920 mm/damon/sysfs.c
> 
> 399d9187753ad1 SeongJae Park 2025-12-02  900  
> 381d987c8a405a SeongJae Park 2025-12-02  901  static int damon_sysfs_sample_add_dirs(
> 381d987c8a405a SeongJae Park 2025-12-02  902  		struct damon_sysfs_sample *sample)
> 381d987c8a405a SeongJae Park 2025-12-02  903  {
> 381d987c8a405a SeongJae Park 2025-12-02  904  	struct damon_sysfs_primitives *primitives;
> 4cba4bd330b3be SeongJae Park 2025-12-02  905  	struct damon_sysfs_sample_filters *filters;
> 381d987c8a405a SeongJae Park 2025-12-02  906  	int err;
> 381d987c8a405a SeongJae Park 2025-12-02  907  
> 381d987c8a405a SeongJae Park 2025-12-02  908  	primitives = damon_sysfs_primitives_alloc(true, false);
> 381d987c8a405a SeongJae Park 2025-12-02  909  	if (!primitives)
> 381d987c8a405a SeongJae Park 2025-12-02  910  		return -ENOMEM;
> 381d987c8a405a SeongJae Park 2025-12-02  911  	err = kobject_init_and_add(&primitives->kobj,
> 381d987c8a405a SeongJae Park 2025-12-02  912  			&damon_sysfs_primitives_ktype, &sample->kobj,
> 381d987c8a405a SeongJae Park 2025-12-02  913  			"primitives");
> 381d987c8a405a SeongJae Park 2025-12-02  914  	if (err)
> 381d987c8a405a SeongJae Park 2025-12-02  915  		goto put_primitives_out;
> 381d987c8a405a SeongJae Park 2025-12-02  916  	sample->primitives = primitives;
> 381d987c8a405a SeongJae Park 2025-12-02  917  
> 4cba4bd330b3be SeongJae Park 2025-12-02  918  	filters = damon_sysfs_sample_filters_alloc();
> 4cba4bd330b3be SeongJae Park 2025-12-02  919  	if (!filters)
> 4cba4bd330b3be SeongJae Park 2025-12-02 @920  		goto put_primitives_out;
> 4cba4bd330b3be SeongJae Park 2025-12-02  921  	err = kobject_init_and_add(&filters->kobj,
> 4cba4bd330b3be SeongJae Park 2025-12-02  922  			&damon_sysfs_sample_filters_ktype, &sample->kobj,
> 4cba4bd330b3be SeongJae Park 2025-12-02  923  			"filters");
> 4cba4bd330b3be SeongJae Park 2025-12-02  924  	if (err)
> 4cba4bd330b3be SeongJae Park 2025-12-02  925  		goto put_filters_out;
> 4cba4bd330b3be SeongJae Park 2025-12-02  926  	sample->filters = filters;
> 4cba4bd330b3be SeongJae Park 2025-12-02  927  	return 0;
> 4cba4bd330b3be SeongJae Park 2025-12-02  928  put_filters_out:
> 4cba4bd330b3be SeongJae Park 2025-12-02  929  	kobject_put(&filters->kobj);
> 4cba4bd330b3be SeongJae Park 2025-12-02  930  	sample->filters = NULL;
> 381d987c8a405a SeongJae Park 2025-12-02  931  put_primitives_out:
> 381d987c8a405a SeongJae Park 2025-12-02  932  	kobject_put(&primitives->kobj);
> 381d987c8a405a SeongJae Park 2025-12-02  933  	sample->primitives = NULL;
> 381d987c8a405a SeongJae Park 2025-12-02  934  	return err;
> 381d987c8a405a SeongJae Park 2025-12-02  935  }
> 381d987c8a405a SeongJae Park 2025-12-02  936  

Nice catch, thank you for reporting this!  I just pushed below fixup.

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index d05083572452..cf0ae45d0a04 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1233,8 +1233,10 @@ static int damon_sysfs_sample_add_dirs(
        sample->primitives = primitives;

        filters = damon_sysfs_sample_filters_alloc();
-       if (!filters)
+       if (!filters) {
+               err = -ENOMEM;
                goto put_primitives_out;
+       }
        err = kobject_init_and_add(&filters->kobj,
                        &damon_sysfs_sample_filters_ktype, &sample->kobj,
                        "filters");


Thanks,
SJ

[...]

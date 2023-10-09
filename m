Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F13B7A4;
	Mon,  9 Oct 2023 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACfLtQq+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB51C433C8;
	Mon,  9 Oct 2023 23:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696895811;
	bh=gxlUrPC4yVKolLGJekFBRga1t6q6wtnBb7ZtUg+4hOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACfLtQq+JbMTveNv9Xrghw/S+sOWBkmP53d4gxLplvKUz8qAr71gcV9koD743T26w
	 Km+WKju/gMYNmsb9fhRI8rHZ48Lrx7sjCxfWMX9FdctCg014nO8O2k0GEE/OA0zqnw
	 ICoetq9jPErWASQoU71qpDijeBbHRhQUml9uZWSKRh6E6A/FooSC/k2fEFdTi7ggiE
	 cFdREhfdZ1OxkMZhTcDq6J73Z+sAkSbDFSH5OcQHK3ls69jy2fEOBmst088zz5DGjY
	 M8pkXOocV37zHM0Vkawwp9lnvLF2nn4IQ95jiJ7pwVEMEcakJ0Bou3EizZ6G4qqHyX
	 uy8pZX/oRWK8A==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 27/28] hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a892_bpf_trace_run2+0, recompile with -ffunction-sections
Date: Mon,  9 Oct 2023 23:56:49 +0000
Message-Id: <20231009235650.9301-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202310090405.GXbIXpan-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Robot,

On Mon, 9 Oct 2023 04:40:31 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   b51b81a2d623ddeda365270f24748bea23a93a2f
> commit: 8a198cce537de4f58f1cd791cd05347320a025b3 [27/28] mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
> config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310090405.GXbIXpan-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090405.GXbIXpan-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310090405.GXbIXpan-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a892_bpf_trace_run2+0, recompile with -ffunction-sections
>    hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
>    hppa-linux-ld: final link failed: bad value

Thank you for this report!  Nevertheless, I was unable to reproduce the issue.
It indeed fails the build, but with a different error.  Also, I get the same
error on the baseline of the tree, namely mm-unstable (specifically, commit
e0b0922d61a8).

    hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
    (.text+0x4a24): undefined reference to `.L874'
    make[3]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:36: vmlinux] Error 1
    make[3]: Target '__default' not remade because of errors.
    make[2]: *** [/home/sjpark/linux/Makefile:1165: vmlinux] Error 2
    make[2]: Target '__all' not remade because of errors.
    make[1]: *** [/home/sjpark/linux/Makefile:234: __sub-make] Error 2
    make[1]: Target '__all' not remade because of errors.
    make[1]: Leaving directory '/home/sjpark/linux.parisc.out'
    make: *** [Makefile:234: __sub-make] Error 2
    make: Target '__all' not remade because of errors.

I'm also not sure how the commit you found could make such error, since the
commit doesn't touch any of xfs code.

    $ git log 8a198cce537de4f58f1cd791cd05347320a025b3 --stat -1
    commit 8a198cce537de4f58f1cd791cd05347320a025b3
    Author: SeongJae Park <sj@kernel.org>
    Date:   Fri Oct 6 22:58:00 2023 +0000
    
        mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
    
        Signed-off-by: SeongJae Park <sj@kernel.org>
    
     mm/damon/sysfs-common.h  |  2 ++
     mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
     mm/damon/sysfs.c         | 25 +++++++++++++++++++++----
     3 files changed, 39 insertions(+), 4 deletions(-)

Anything I'm missing?  Or, could this report be mistakenly made?


Thanks,
SJ

> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

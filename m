Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67060273D9;
	Thu, 12 Oct 2023 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5+vYEE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A708C433C8;
	Thu, 12 Oct 2023 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697125617;
	bh=2oUTgdvvt7Npo39v41Ve6hpVDc/UAFCXJgxXHtGL9os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5+vYEE0nMSitIyDBqywKADX9ktL9v/gC8/yTLYqZhdbbuByIi8DeVljHcgJzkVBp
	 MLq+d7c+Mi3d17sACQ5ZXSETIdbkx8Fy5aON/DnTvq3vfdW2KpTJ9WgctcdzLW2GMa
	 dhTPM1z6Mm802WKDrGc9UcdMsOqIdF+gwfrtOGrTCZK04SbKwIk7onAjm5AcK3LIfs
	 0hPKUteGNAhLSLr3ZEzX4VqWTf3xFHv7i7x8gJNDjH84IC5+Aai1dfi2UEeqbtcl9f
	 wixO8L2sP8xAssndt6xE9GCNxREKgFfoWZZDCz3cnMZHBHOxOgeYYMghDrUOkUv1R5
	 8rcEIYTO5TbHQ==
From: SeongJae Park <sj@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	kernel test robot <lkp@intel.com>,
	damon@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 27/28] hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a892_bpf_trace_run2+0, recompile with -ffunction-sections
Date: Thu, 12 Oct 2023 15:46:56 +0000
Message-Id: <20231012154656.32743-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZSduHlPmRa4HIuTm@yujie-X299>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yujie,

On Thu, 12 Oct 2023 11:55:10 +0800 Yujie Liu <yujie.liu@intel.com> wrote:

> Hi SJ,
> 
> On Mon, Oct 09, 2023 at 11:56:49PM +0000, SeongJae Park wrote:
> > Hi Robot,
> > 
> > On Mon, 9 Oct 2023 04:40:31 +0800 kernel test robot <lkp@intel.com> wrote:
> > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> > > head:   b51b81a2d623ddeda365270f24748bea23a93a2f
> > > commit: 8a198cce537de4f58f1cd791cd05347320a025b3 [27/28] mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
> > > config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310090405.GXbIXpan-lkp@intel.com/config)
> > > compiler: hppa-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090405.GXbIXpan-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202310090405.GXbIXpan-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > > >> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a892_bpf_trace_run2+0, recompile with -ffunction-sections
> > >    hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
> > >    hppa-linux-ld: final link failed: bad value
> > 
> > Thank you for this report!  Nevertheless, I was unable to reproduce the issue.
> > It indeed fails the build, but with a different error.  Also, I get the same
> > error on the baseline of the tree, namely mm-unstable (specifically, commit
> > e0b0922d61a8).
> > 
> >     hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
> >     (.text+0x4a24): undefined reference to `.L874'
> >     make[3]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:36: vmlinux] Error 1
> >     make[3]: Target '__default' not remade because of errors.
> >     make[2]: *** [/home/sjpark/linux/Makefile:1165: vmlinux] Error 2
> >     make[2]: Target '__all' not remade because of errors.
> >     make[1]: *** [/home/sjpark/linux/Makefile:234: __sub-make] Error 2
> >     make[1]: Target '__all' not remade because of errors.
> >     make[1]: Leaving directory '/home/sjpark/linux.parisc.out'
> >     make: *** [Makefile:234: __sub-make] Error 2
> >     make: Target '__all' not remade because of errors.
> > 
> > I'm also not sure how the commit you found could make such error, since the
> > commit doesn't touch any of xfs code.
> > 
> >     $ git log 8a198cce537de4f58f1cd791cd05347320a025b3 --stat -1
> >     commit 8a198cce537de4f58f1cd791cd05347320a025b3
> >     Author: SeongJae Park <sj@kernel.org>
> >     Date:   Fri Oct 6 22:58:00 2023 +0000
> >     
> >         mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
> >     
> >         Signed-off-by: SeongJae Park <sj@kernel.org>
> >     
> >      mm/damon/sysfs-common.h  |  2 ++
> >      mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
> >      mm/damon/sysfs.c         | 25 +++++++++++++++++++++----
> >      3 files changed, 39 insertions(+), 4 deletions(-)
> > 
> > Anything I'm missing?  Or, could this report be mistakenly made?
> 
> Sorry this is a false positive report. We did some investigation and the
> story is a bit complicated.
> 
> We set some extra flags during compiling, but sorry this is not
> clearly mentioned in the report.
> 
> When no flag is set, we get the same error as you:
> 
> $ make W=1 --keep-going ARCH=parisc
> hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
> (.text+0x4a24): undefined reference to `.L874'
> 
> When the extra flags are set, the error is:
> 
> $ make W=1 --keep-going KBUILD_CFLAGS_KERNEL="-falign-functions=64" KBUILD_CFLAGS_MODULE="-DMODULE -falign-functions=64" ARCH=parisc
> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a890_bpf_trace_run2+0, recompile with -ffunction-sections
> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
> hppa-linux-ld: final link failed: bad value
> 
> If we build on the parent of ("mm/damon/sysfs: avoid empty scheme
> tried regions for large apply interval"), which is
> ("mm/damon/sysfs-schemes: do not update tried regions more than one
> DAMON snapshot"), the error is like:
> 
> $ make W=1 --keep-going KBUILD_CFLAGS_KERNEL="-falign-functions=64" KBUILD_CFLAGS_MODULE="-DMODULE -falign-functions=64" ARCH=parisc
> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a88d_bpf_trace_run2+0, recompile with -ffunction-sections
> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
> hppa-linux-ld: final link failed: bad value
> 
> The hex in the function name changes. (0000a88d_bpf_trace_run2 ->
> 0000a890_bpf_trace_run2), so the bot wrongly thinks that a new error
> appears on the reported commit.
> 
> Not sure if the code layout has some minor changes when the alignment
> flags are set, or if any problem at cross toolchain side.

Interesting, thank you so much for sharing this deep and grateful investigation
results!

> 
> Anyway, your patches are certainly not related to this error in xfs code.
> We will update the bot's code to handle this case and similar ones.
> Sorry for bothering you.

No problem at all.  The bot's contribution is really grateful and very helpful.
Without it, I don't think I can maintain DAMON.  So, never mind, and please
continue this great work.


Thanks,
SJ

> 
> Best Regards,
> Yujie
> 

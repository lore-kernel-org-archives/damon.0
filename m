Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC120EE;
	Thu, 12 Oct 2023 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWOQiXCS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697083223; x=1728619223;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wIdWAYIxeLdqZgPeLxZ1G4BG4dmsFz++MEEgKl+qlps=;
  b=UWOQiXCSvAqvJ79G79GZC1QoR1Q2Otx83IkWxXYNDlv/xo7VmCDLzkM4
   /MyVa4ZHYups22vy9tXZKNUnA7O3MXIzGa745cj0/taupA1Ey8axovguz
   etolvQ0HIi4t8OMFQuef4O47Al8tqW2quObyXG5H29QP8HVa6EFhRhThV
   mqm5UMCEgykaJZfNngK04a9i51Hp/UcFzBvIi46YNkgBAYmi4eF/7nOkF
   M59wU/d27/o8AqJ8GOeAC24xY1K5ZifkObWfbP4oacr0/kzYgaNZw28qe
   r2amtqh3P6oSs7LLTryHaUS6nntO1iV3Qksbgy9iFL4noYXuRo9ZsdCky
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3411469"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="3411469"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 21:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="783523510"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="783523510"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 21:00:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 21:00:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 21:00:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 21:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9JQPyD0Nvd357n9Usfg8vdrva6ddNELBMIjxkYWOUpfvB4SiwbDR/ZaGBUNdT90gZjJtJY+6U3uc9TnmaL7RopIXn2oRaMtlAZszVFZkG0E0ItYUNS7qK3/GndjHDgwcRkEbmvpgm9zGbvjbH5w73zSoZYaBUnFyM8NzVFdHI6BccEmUYNw3fY5N24TVqmcUJME2l5fFm5zsVVzJ077jeoJbh7FzsBMx4cb1+SM4dBuER6RbGJn/FOR+uvLL6eCVRPERd4zrKMgTWtITQncQH6I4atm9YBMm9wwvQcu6zHKCuL5x3T33nranAT2skpo0lftz0tEDMuPdq6F4/Scmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SUgptEph7J6t5tkSuVcmzeQIYgctrjf6OemvI8PT8Y=;
 b=ANdqTaVYt1e1cFByEzsZ6jRlaHEu/y2LRtfZAPPyij0hIpP+noSaHZkLNAk5BMhZDpujlJv6xSlK6Gg1b6g28ZHLUWygPdqwVWzq6wgxFlCi4OyGl8irc/5EJQWZQUrijFcTa7pcs+yyZ2xS4rPOIyJ4uUXbClbHtwafjJ7Tz89jt6Ny+I1fECJ5P/ti/4lwqEB/O45eTK7rC/L1vOprMXL6qbMfcEz7WPHNABGrow1VU3vSe6p0JImM5LbgEXJ8xB5WtQxrmPWCET9DUZUscZwlKxhoWkz31m/TWN6XFQMZEXGfnNFNumHOqDeyaQq4OrvnxXXo/0a27eOgO+iwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH0PR11MB5689.namprd11.prod.outlook.com (2603:10b6:610:ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 04:00:08 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 04:00:08 +0000
Date: Thu, 12 Oct 2023 11:55:10 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: SeongJae Park <sj@kernel.org>
CC: kernel test robot <lkp@intel.com>, <damon@lists.linux.dev>,
	<oe-kbuild-all@lists.linux.dev>
Subject: Re: [sj:damon/next 27/28] hppa-linux-ld:
 fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a892_bpf_trace_run2+0,
 recompile with -ffunction-sections
Message-ID: <ZSduHlPmRa4HIuTm@yujie-X299>
References: <202310090405.GXbIXpan-lkp@intel.com>
 <20231009235650.9301-1-sj@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231009235650.9301-1-sj@kernel.org>
X-ClientProxiedBy: SG2PR02CA0115.apcprd02.prod.outlook.com
 (2603:1096:4:92::31) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH0PR11MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc22b22-c271-4ab0-b7c5-08dbcad7b80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9582oieViecEOPN28PaqWQcx8FPc/7SuxZrblQJ/QKawfT/GZpwa/YYUNY9Za51vSr81R9C9PYdJwNAAwueu0BOiZN9OfG902Nb1fhRIz0DPYA3NVyeBwTK92j/+woJqLlNBIqK7feiGw0RGOrrqnWUEh8WcbO8WOuzN1ob4vHWoaSwRRghh/Du/rZdkUXJaqFvzt82lI+WN0raynt32b0saJ3EGIatwnDW/NJeR1AUtTRdVAd4FGJIRG0r7lBy8fnfiCYZiQxYIozluOv3y0NpULiR7PibRf66liqFUzaB8qyCaXnjK+8mLzbWBjyyhTmvPJQRi9PBrHjvQMW3lWogRSZUmIMYFFNrJ3JVQcI9A97LCzjQWMFVySPtzISmPi+GEhd0YMq83+JTx/YgaiSZBKlqwXWTbT/e0uGNiUcFI1h0KB6HA7Ga5co6YYbS4YL35n/q0blVReha5ezAuYUNJ/cNm30MOOJHtPui+RxJUlFwcdPPDxjrbS7U9A08MxNxg6rkXCoq2Pue4wmD2O518Q1LYL9lUQunPQOjEqwa6Kn06YgLZa0O1naLROr1J/oJHViSeQD8So2UBcYE0Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(82960400001)(33716001)(38100700002)(966005)(6512007)(5660300002)(9686003)(6486002)(2906002)(6506007)(66946007)(6666004)(44832011)(41300700001)(4326008)(8936002)(26005)(66476007)(66556008)(8676002)(316002)(478600001)(83380400001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AkW59BbiyRf/mXKpl2XBU5Mf1ePGBcz65o74+T8YhiXaclgE9/qOjAgt6U0e?=
 =?us-ascii?Q?od7imAtsmG+KBN5d6fQoDgFFqJQB7ynC5XzYroiXaQL4HpGhIO02fUUv+Okp?=
 =?us-ascii?Q?cLcwgJbGC0oV3BL2Ly16BPM617icVyXWIJzmEHlYZ6mytlbJS+IOEH4jztl0?=
 =?us-ascii?Q?x2HEfDE0OerxzS8lm0761MCMzAtN+nJ/26HaQfsMr0FWSJss6w/OL3f6FaaX?=
 =?us-ascii?Q?aK6EiyA+rnAOulwWfXZOhNi1FjglcrO9MQX3tuNy4bI4/6OPVxPXDCcAanFZ?=
 =?us-ascii?Q?f6StcUfoh0MgRx3FJBXjXqVA65s5CMQvRtxCZ2BldXzUc9ZZturxd/3/4HUl?=
 =?us-ascii?Q?s3uRfGPzB4b/A7XQ0abtovv8tVK6gGwo0FixllmuI5Sn4+h4hHoG+xpooWiF?=
 =?us-ascii?Q?TbVskkKJo5HctMn4jWjGnuJ75uYSH+S2kcsLeQy17aeTl4FZ/SEZTIIXubZ9?=
 =?us-ascii?Q?1Rd/IGmdgmud8CoFIvCYm2tdZEHEzqXwjD5r/prKjgVxNh9Hq9/GwWIMb+2f?=
 =?us-ascii?Q?0R/SSCeg23Fp0GVJRYanbxJSZrAl2p/iCoFRymDjPTWaOGbUHAMpV5wtpis7?=
 =?us-ascii?Q?b7+UoTHYkqQBbK8TdL4dWx5oJNaDyceY8ibtUUCJmeBhLQOIZt3TpRgqEIPb?=
 =?us-ascii?Q?b6LWQ53kttvxP7kZkP6c8r69UnHnk8/uY/tm9trwiHpc/Tat/Rc0mcD2I0SX?=
 =?us-ascii?Q?/YQB/HBpQ8Uff8KLtiBWi2pQkT8zqHrqh5uo8Hn57ighYQua0tD/uK3VKHJU?=
 =?us-ascii?Q?5saeh2o6Lx4UgipkeHJ15pUal5xpvFCIkp7tKa1O9Y+sDpvYOM3gicyXetn7?=
 =?us-ascii?Q?NrM3EQ1x1HPUTC7bTLZe6EiVckqZUkNak8YuPgHtN2w3/sTTMxaTwdbXSHm1?=
 =?us-ascii?Q?fgeLyWyzXypQZXB9asOxPhT/64G8M3iv0eN8QdXMiyYmtKN6kzzz9+IzOyID?=
 =?us-ascii?Q?DbKNfbR06c6KoCheBgwuCZRA7T04fIkqHKQz0dnP/qsWVpoUzTWKaI6aMEn5?=
 =?us-ascii?Q?CjJBZ+SI/hNkTB4SwuSrehj3Dkwpg35esEiuwpFdjn1XXQFtMGycWyNr0TIm?=
 =?us-ascii?Q?NDc1ZfV+pwuMRFooSlWcZ3J+FIweG2dZnDmtT5dUwMZC7Db5zlmXyHsLW53S?=
 =?us-ascii?Q?xwlksbt+GLFfZu220bD2OeWZSw+PiRzy2Q5mKVBITowI412H/DjlRagzz7FH?=
 =?us-ascii?Q?eu9ewt0t+TrLbbcIHpZsRppwIsEV5xpvDXlLzFVSsri3fgsibeaqLMhqCVpL?=
 =?us-ascii?Q?OiY1z0N+o1h5R7BhR+2nGbKA5PlSKGRTO62Vkd5rJ8f8c8mTD1ePcJCGVpNe?=
 =?us-ascii?Q?8pGc+Xke2Wyy0ylVu/cEFsaujN2BlM8lsGwxqubIqv5JYWaVy5ItnamIBZAj?=
 =?us-ascii?Q?x/6rOJ5tYJ3q5ZA5cGmKMIHa6uRO7C5LyRQ5lQeax88ko6s3+FAAC8ppIhYh?=
 =?us-ascii?Q?c6O2RaiPVI5mz7Z/E3LiO9axGC+gERjnUf6Qxhp++Bk56amDi+kucuu18edp?=
 =?us-ascii?Q?76daKBtPKw+ssX7AJp0MzS3/2XUJYOL/695a4U7BRmKw/Y79/+wvs5DP/yTb?=
 =?us-ascii?Q?IA7L1oIr8eDTwhre1BO7T8l/hdYmpHbg5Z2b9P5U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc22b22-c271-4ab0-b7c5-08dbcad7b80d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 04:00:08.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K1C1U3S0aOvwLuDQit770bFHHkoV5sVZCPOGHKtIalmzyWRSdcRIzzQUcQk4aJNDeAgqkjAZMOJuIMAar0gcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5689
X-OriginatorOrg: intel.com

Hi SJ,

On Mon, Oct 09, 2023 at 11:56:49PM +0000, SeongJae Park wrote:
> Hi Robot,
> 
> On Mon, 9 Oct 2023 04:40:31 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> > head:   b51b81a2d623ddeda365270f24748bea23a93a2f
> > commit: 8a198cce537de4f58f1cd791cd05347320a025b3 [27/28] mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
> > config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231009/202310090405.GXbIXpan-lkp@intel.com/config)
> > compiler: hppa-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090405.GXbIXpan-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310090405.GXbIXpan-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a892_bpf_trace_run2+0, recompile with -ffunction-sections
> >    hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
> >    hppa-linux-ld: final link failed: bad value
> 
> Thank you for this report!  Nevertheless, I was unable to reproduce the issue.
> It indeed fails the build, but with a different error.  Also, I get the same
> error on the baseline of the tree, namely mm-unstable (specifically, commit
> e0b0922d61a8).
> 
>     hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
>     (.text+0x4a24): undefined reference to `.L874'
>     make[3]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:36: vmlinux] Error 1
>     make[3]: Target '__default' not remade because of errors.
>     make[2]: *** [/home/sjpark/linux/Makefile:1165: vmlinux] Error 2
>     make[2]: Target '__all' not remade because of errors.
>     make[1]: *** [/home/sjpark/linux/Makefile:234: __sub-make] Error 2
>     make[1]: Target '__all' not remade because of errors.
>     make[1]: Leaving directory '/home/sjpark/linux.parisc.out'
>     make: *** [Makefile:234: __sub-make] Error 2
>     make: Target '__all' not remade because of errors.
> 
> I'm also not sure how the commit you found could make such error, since the
> commit doesn't touch any of xfs code.
> 
>     $ git log 8a198cce537de4f58f1cd791cd05347320a025b3 --stat -1
>     commit 8a198cce537de4f58f1cd791cd05347320a025b3
>     Author: SeongJae Park <sj@kernel.org>
>     Date:   Fri Oct 6 22:58:00 2023 +0000
>     
>         mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
>     
>         Signed-off-by: SeongJae Park <sj@kernel.org>
>     
>      mm/damon/sysfs-common.h  |  2 ++
>      mm/damon/sysfs-schemes.c | 16 ++++++++++++++++
>      mm/damon/sysfs.c         | 25 +++++++++++++++++++++----
>      3 files changed, 39 insertions(+), 4 deletions(-)
> 
> Anything I'm missing?  Or, could this report be mistakenly made?

Sorry this is a false positive report. We did some investigation and the
story is a bit complicated.

We set some extra flags during compiling, but sorry this is not
clearly mentioned in the report.

When no flag is set, we get the same error as you:

$ make W=1 --keep-going ARCH=parisc
hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
(.text+0x4a24): undefined reference to `.L874'

When the extra flags are set, the error is:

$ make W=1 --keep-going KBUILD_CFLAGS_KERNEL="-falign-functions=64" KBUILD_CFLAGS_MODULE="-DMODULE -falign-functions=64" ARCH=parisc
hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a890_bpf_trace_run2+0, recompile with -ffunction-sections
hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
hppa-linux-ld: final link failed: bad value

If we build on the parent of ("mm/damon/sysfs: avoid empty scheme
tried regions for large apply interval"), which is
("mm/damon/sysfs-schemes: do not update tried regions more than one
DAMON snapshot"), the error is like:

$ make W=1 --keep-going KBUILD_CFLAGS_KERNEL="-falign-functions=64" KBUILD_CFLAGS_MODULE="-DMODULE -falign-functions=64" ARCH=parisc
hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot reach 0000a88d_bpf_trace_run2+0, recompile with -ffunction-sections
hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x42da0): cannot handle R_PARISC_PCREL17F for bpf_trace_run2
hppa-linux-ld: final link failed: bad value

The hex in the function name changes. (0000a88d_bpf_trace_run2 ->
0000a890_bpf_trace_run2), so the bot wrongly thinks that a new error
appears on the reported commit.

Not sure if the code layout has some minor changes when the alignment
flags are set, or if any problem at cross toolchain side.

Anyway, your patches are certainly not related to this error in xfs code.
We will update the bot's code to handle this case and similar ones.
Sorry for bothering you.

Best Regards,
Yujie

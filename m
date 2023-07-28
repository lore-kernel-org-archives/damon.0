Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0263C8EF;
	Fri, 28 Jul 2023 08:18:36 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-563d3e4f73cso1013271a12.3;
        Fri, 28 Jul 2023 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532316; x=1691137116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6cirw1FEkCs0UFapxliUJRvhCFx7ayk/EAB6b5XJMc=;
        b=KYGB69fibv3PnjpeJY9meN0zIhVGg04Vi/Xujei0Kw3lMa/nPPiKek8hwJj9xzDsXM
         qm0VLveFbtL9GIGKZheCrCqTSPmNSbMgFfh+e7DjO9ANXZbkZWSVM6zD6bPJZym6Y2p6
         KT8pnL5RH0EXEb0whhQAAVr723+Z5m62sIxN1xJnS0GwZC7irO0fo4FMs2BdE1mx1aq3
         4iwnNyfztMp26DOVWpQRr8tpLxEU0jJaiiSM5NzNVz3yxTqTd7yFnu7mNN2fNhouwU7C
         tGbssS5EVgwVMLXbSLAxLgxAB3eWRdknrqIPROa3Bps3TMv101+Zlib6oc/In+xyz+yF
         Q0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532316; x=1691137116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6cirw1FEkCs0UFapxliUJRvhCFx7ayk/EAB6b5XJMc=;
        b=b9/VfRWcvKPPzEyeCkQGBe4bz4SjNkx8ic7nUHbvPBrbU5oMghx+EjhVSE3mW2ewrv
         wCCKc6XDB5uQzEGkHJkKtnY+YkJ0RXBLyRSmN80ZPU7YJiY2TAc4NZ4GP8Xg0JdaXfIH
         A03lGFjqXbX40a3drbPWilS99z653NYS+XqCHg9hzHwDPSDNJIPcQyUuUq7o9OAwQCx8
         +OaKkIJQh9+f3adHDh70eRG52EBzcGAtDTYXaxH5thCE5FxAPnwZ56G3gyKfD8m5S2AM
         zkatXmjiOKt1yvdlopXi3JpceetG2vgKFuQilqaTkhybn2s69b1Zz3DnARHdfnImx1U/
         wIdA==
X-Gm-Message-State: ABy/qLbYoKSL1rTh1kG9G4QxvUc1JmzaCMDiek1etEANhS5UhEiZFfZN
	4jRIPVa5tBeT5X27XziovOE+kkdfZBrdJVaEMgA=
X-Google-Smtp-Source: APBJJlHM8Zn8kT2EFNEa6upZZLdsWLxpg71dojcpGQLt+yjDA0dRl+2oTM2kcp3EPoqBIhVmdJGP8xCB1yPOFPrbf0o=
X-Received: by 2002:a17:90b:3b8a:b0:268:420:2e04 with SMTP id
 pc10-20020a17090b3b8a00b0026804202e04mr540791pjb.49.1690532315768; Fri, 28
 Jul 2023 01:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727183745.682880-1-ppbuk5246@gmail.com> <202307281532.pVsrTsL2-lkp@intel.com>
In-Reply-To: <202307281532.pVsrTsL2-lkp@intel.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Fri, 28 Jul 2023 09:18:24 +0100
Message-ID: <CAM7-yPS6Ob0pcMpTc=Lirw5WARgAgGcRzO-iosf19dzEmAf1wQ@mail.gmail.com>
Subject: Re: [PATCH] damon: Use pmdp_get instead of drect dereferencing pmd.
To: kernel test robot <lkp@intel.com>
Cc: sj@kernel.org, akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev, 
	damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This build warning is fixed in v2:
    https://lore.kernel.org/all/20230727212157.2985025-1-ppbuk5246@gmail.co=
m/

On Fri, Jul 28, 2023 at 9:09=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Levi,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master v6.5-rc3 next-20230728]
> [cannot apply to sj/damon/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Levi-Yun/damon-Use=
-pmdp_get-instead-of-drect-dereferencing-pmd/20230728-024044
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20230727183745.682880-1-ppbuk524=
6%40gmail.com
> patch subject: [PATCH] damon: Use pmdp_get instead of drect dereferencing=
 pmd.
> config: i386-randconfig-i016-20230727 (https://download.01.org/0day-ci/ar=
chive/20230728/202307281532.pVsrTsL2-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281532=
.pVsrTsL2-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307281532.pVsrTsL2-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    mm/damon/vaddr.c: In function 'damon_young_pmd_entry':
> >> mm/damon/vaddr.c:440:15: warning: unused variable 'pmde' [-Wunused-var=
iable]
>      440 |         pmd_t pmde;
>          |               ^~~~
>
>
> vim +/pmde +440 mm/damon/vaddr.c
>
>    434
>    435  static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>    436                  unsigned long next, struct mm_walk *walk)
>    437  {
>    438          pte_t *pte;
>    439          pte_t ptent;
>  > 440          pmd_t pmde;
>    441          spinlock_t *ptl;
>    442          struct folio *folio;
>    443          struct damon_young_walk_private *priv =3D walk->private;
>    444
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

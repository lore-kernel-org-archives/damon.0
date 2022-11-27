Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523F6AA6;
	Sun, 27 Nov 2022 18:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E192CC433D6;
	Sun, 27 Nov 2022 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669575161;
	bh=NIIJlLgp/x7uMjF8WQ+7w/VUHqd6Tc7r7AMNGaKzYOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZFVrzwYy0HQWy+6B7MNuruj8SK2zZyjTHdSbTOF7w1H8TQp0VaImF8l3/a87WvfLN
	 +ZzQSGbr+aqHH/uNnHQTCxOwqZjajBsie1CHaKQAfMW7b59NeHCQ+J8QGk8bHVaO1B
	 3rWhcUHOKC/r5FA4BzgNPEvhLn1bM/FiY73/a7XMYs7dWS4Zi/5lWJwS1QDv2CSU9D
	 jnWV5Wxl/mF/snNwqsFqXhUYw1uAukXkNAcKy4X3pcFCvvh+ROd4VvgNNVg2z7qh5w
	 dsjDSX1URiJNgmjXLhUFzy3B47aS/5oqTYASNqRcwHkP1IIj74/3KRh94UznzR3laO
	 jOkwsTUOL0QEA==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [sj:damon/next 27/30] mm/damon/sysfs-schemes.c:1409:26: error: invalid use of undefined type 'struct mem_cgroup'
Date: Sun, 27 Nov 2022 18:52:39 +0000
Message-Id: <20221127185239.82898-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202211261843.IwGJRcdf-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Robot,


Thank you always for the report!

On Sat, 26 Nov 2022 18:26:31 +0800 kernel test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 1887 bytes --]
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   61742c95d33e74cf64b7d5b8e51f12adef425b3e
> commit: d768680bbe8153f2b79382bd2cd5d6734b6f5c42 [27/30] mm/damon/sysfs-schemes: implement scheme filters
> config: xtensa-randconfig-r014-20221124
> compiler: xtensa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?id=d768680bbe8153f2b79382bd2cd5d6734b6f5c42
>         git remote add sj https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git
>         git fetch --no-tags sj damon/next
>         git checkout d768680bbe8153f2b79382bd2cd5d6734b6f5c42
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash mm/damon/

I couldn't reproduce this issue as the last command above gives me below error.

    $ COMPILER_INSTALL_PATH=$HOME/0day make.cross W=1 O=../build_test ARCH=xtensa SHELL=/bin/bash mm/damon/
    Compiler will be installed in /home/xxxx/0day
    Please update: libc6
    ldd /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc
    /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc)
    /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by /home/xxxx/0day/gcc-12.1.0-nolibc/xtensa-linux/bin/xtensa-linux-gcc)
    setup_crosstool failed

> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    mm/damon/sysfs-schemes.c: In function 'damon_sysfs_memcg_path_eq':
> >> mm/damon/sysfs-schemes.c:1409:26: error: invalid use of undefined type 'struct mem_cgroup'
>     1409 |         cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
>          |                          ^~

Nevertheless, seems the issue was due to missed inclusion of memcontrol.h,
which defines the 'struct mem_cgroup'.  Fixed and pushed[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git/commit/?h=damon/next&id=7eaaa606788b0766ece3c105fdcf963aba8511ef


Thanks,
SJ

[...]

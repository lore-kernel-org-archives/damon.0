Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55068126F0A;
	Sun,  4 Jan 2026 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549426; cv=none; b=IiC5yhEebwhNyn+JQ7lKOoKaXVMZNLYysLbIA9n+sIwBjWvbKwLjWL7/riYvCosx6r3fV3xZWR4rXAyM1nsWN1xtyl7NomlCm6iqr3kx+xaHH1vx4LESfz/0vH4kTF+JN96BiEZnl/XNDsncTmsmnJIYOvx6jBy30gXZofFed2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549426; c=relaxed/simple;
	bh=x1nTKAnylCVX9MkM3owrH+0o0UMQ59gwlM/bk3ClXlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWSYW9IS3vz1c9ibPVK8mDU6Qg1jmnyu7UN6qB/XuwcEj/rMBKOKhc9z6G+oiwPMTS52d6Zn4AR1OLx45LtaOKHEbxhTnJwDlsmxVKXGcrHpsOvUsEJHqQ2tzdtjPf0CrV2nZoFTlEE8dSnSSmRloych/wu08UNeB5MlwoiihwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cylcqxt9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cylcqxt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E963C19421;
	Sun,  4 Jan 2026 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767549426;
	bh=x1nTKAnylCVX9MkM3owrH+0o0UMQ59gwlM/bk3ClXlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cylcqxt9bw72yxbJmPw4Pp37ZBxVaS4bC7kFNXF5302Hd7ABMuaSGzMtWY1lYoWhx
	 h0YscHLNcth4jhLq5eSay1vL6oYDWPKB4NzVGhsurFZPAcZb93sHMM+nrNlXTeA0S3
	 d8Y+Js0Vs7pSG8KTaWYzmLuW8CYt+1OGwVpab0HRWJclq/SRFyBjRzgvFtsMzzjAv/
	 cThsC+CA7Zy70+nj6fiKor0y4nWN8Zh9zbZwQAj9oSV+nE3bIPkkjd34Je5EBXQTEC
	 PDPgd5pBGr5DtPwBusWGbrgh3hdHkFEw04nIaj9lLUpVSSqSMdjDM580UUty+zAXAy
	 sYRszjF2sA7VA==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sj@kernel.org>,
	oe-kbuild-all@lists.linux.dev,
	linux-doc@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [sj:damon/next 110/118] htmldocs: Documentation/admin-guide/mm/damon/usage.rst:9: WARNING: Mismatch: both interpreted text role prefix and reference suffix. [docutils]
Date: Sun,  4 Jan 2026 09:57:02 -0800
Message-ID: <20260104175704.57959-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <202601040942.MWKEmMKA-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 04 Jan 2026 09:49:08 +0100 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
> head:   28d3c5e02b31f08aa715cf01ead66c072a9c5d5a
> commit: 5ff971ba3599d1e5d6a1721a85d50969a3c270ca [110/118] Docs/admin-guide/mm/damon/usage: suggest use of DAMON modules
> reproduce: (https://download.01.org/0day-ci/archive/20260104/202601040942.MWKEmMKA-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601040942.MWKEmMKA-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    WARNING: No kernel-doc for file ./include/linux/pci.h
>    ERROR: Cannot find file ./include/linux/mod_devicetable.h
>    WARNING: No kernel-doc for file ./include/linux/mod_devicetable.h
>    ERROR: Cannot find file ./include/linux/bootconfig.h
>    WARNING: No kernel-doc for file ./include/linux/bootconfig.h
> >> Documentation/admin-guide/mm/damon/usage.rst:9: WARNING: Mismatch: both interpreted text role prefix and reference suffix. [docutils]
>    ERROR: Cannot find file ./include/linux/pstore_zone.h
>    ERROR: Cannot find file ./include/linux/pstore_zone.h
>    WARNING: No kernel-doc for file ./include/linux/pstore_zone.h
>    ERROR: Cannot find file ./include/linux/pstore_blk.h
>    ERROR: Cannot find file ./include/linux/pstore_blk.h

Thank you for this report!

> 
> 
> vim +9 Documentation/admin-guide/mm/damon/usage.rst
> 
>      8	
>    > 9	- *Special-purpose DAMON modules.*
>     10	  :ref:`This <damon_modules_special_purpose>`_ is for people who building,

The '_' at the end of the reference was the problem.  I just pushed a fix to
damon/next tree.


Thanks,
SJ

[...]

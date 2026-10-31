Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793480279;
	b=Fva0jpONlNPvoUutq0QY6xwQs1+CjvXiMFIKXGIb4ps9gCxUX745w7+i3NZbjty7YYGX
	 iUa+uHyzyk/tFXXaLDsq0yQLZLuPwlAutL72HIUwplN8xe+Irh1GkhQjD1+Mu3bzJdyw8
	 YkznU+pJcXLq0UTiv6qu69vjq0M7biTgrWAoMo06q39iPCAEc5hQ6QnVfc02rbPbID3GP
	 /BHJeD59SDFFKaJlaQ7J9iAeN0y5C1jCMxiEeEohuzzFZACG93MI5OyyyRUtvv/uv3dQu
	 PJOZaVX+2DoJ+r9u8CNTTPoVaCEUl2Lh7MMWMtfVeYD/U1foh/X59urTx/0NJJpPWHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793480279;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9ME/DwqzmVxiuu2qCC6yi8ywsrQDgzY0nAzN4XnJ72s=;
	b=u3UzNQKQjDKein5hYTbOT8Z36X6c0vZSOktGZrm4+svC5qUML6sN9bi8eb7Mna9IN7Ni
	 R57PKN4XJ40aZ2wJdeiPScXsEtD08QnVSBIvr7JBwiVDZhgFd5briUdj8fuqR/Zu6vulx
	 UqZRizeKVjDzqTpH3bP1vaMVAruf3XxSWMJdOvE2q7BfLwOyZR+oxuFAUCqAzviHsfl5X
	 3glRIXIZNQQvXXzDbw/uIXbfIHut3nKYiuQB0Z19/p+bq2QU36qHRmosPqpVpqyTnQ6ZJ
	 MWnpc2Np0TPURkE59T4uZ99owIxlR8zCWDCWBUqY5ihIY8zPYOCRElyLxKz/Pkndvew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2zKxdT8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38B606A31A
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2zKxdT8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1231F000C1;
	Sat, 31 Oct 2026 20:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793480278;
	bh=9ME/DwqzmVxiuu2qCC6yi8ywsrQDgzY0nAzN4XnJ72s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a2zKxdT88rxs4YIcSMs5D84GMbDVm/XhD4gZ07oiTDLAA8DEkyNOah0XcscTm7V9T
	 +tg978hxHZK64QEYIAcecR8fmrQ3InNoL01bVp5ggvWjEnLhEcwNEfXovgP4QoPXCU
	 FqZ40Ef8/6JGAkCgR1p31s3UKv69HpwHA49ONdsKA9xb3D5qeEm8GAxooClXkaue3K
	 YrVjqRrD0exk3GMWJDolJp7bXkIyh+HzswzwP784X5NIowMtaWlg97SZ7LDzv2h5Kx
	 bV7Ld4p58+p5RjUTcaiM1KQKdhHbCmyrKiaLWXdpm1ssqmxg3mtxtH+pntaMpamt0y
	 zuRSkpiVhGH8g==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	"Shuah Khan" <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 6/6] selftests/damon: remove unused imports of os and sys modules
Date: Sat, 31 Oct 2026 13:57:50 -0700
Message-ID: <20261031205751.97240-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-192115@kernel.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 31 Oct 2026 20:29:00 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] selftests/damon: commit message names wrong removed modules
> --
> 
> commit 55304159b940aad6f9b71d318671a40d9d63ca46
> Author: SJ Park <sj@kernel.org>
> 
> selftests/damon: remove unused imports of os and sys modules
> 
> This commit removes unused Python module imports from two DAMON selftest
> scripts.
> 
> >     selftests/damon: remove unused imports of os and sys modules
> >     
> >     sysfs_no_op_commit_break.py imports os module but never uses it.
> >     sysfs_update_schemes_tried_regions_hang imports the sys module but never
> >     uses it.  Remove the unnecessary imports.
> >     
> >     The issue is found using flake8.
> >     
> >     Signed-off-by: SJ Park <sj@kernel.org>
> 
> [Severity: Low]
> Does the commit message name the wrong removed modules?
> 
> In tools/testing/selftests/damon/sysfs_no_op_commit_break.py, the patch
> removes import sys rather than import os, and os is still used in
> dump_damon_status_dict():
> 
>     file_dir = os.path.dirname(os.path.abspath(__file__))
>     dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
> 
> In tools/testing/selftests/damon/sysfs_update_schemes_tried_regions_hang.py,
> the patch removes import time rather than import sys, and both sys and os
> are still used at module load time:
> 
>     sys.path.append(os.path.dirname(os.path.abspath(__file__)))
> 
> Should the commit subject and message be updated to refer to the sys and
> time modules instead of os and sys?

Good catches.  I will fix these in the next revision.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261031202614.96036-1-sj@kernel.org?part=6
> 


Thanks,
SJ

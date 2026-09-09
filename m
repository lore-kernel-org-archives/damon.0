Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E42492E5D;
	Wed,  9 Sep 2026 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913221; cv=none; b=BhdBZrA8dhMx0dOO5rUqJdwZa/ISkycVECa6HJg/2zX1MkrB5SIUWAhTpZ6b67WCW9jLqnwKTPllFbzBT/6eyPDLI++ikpS4yORnHnVo/wcb4JElRsJGoS/ys/7P6mQRfLC4ONkJPRjoDsDSRjojcD0xYr0LDH0YsTOw785fPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913221; c=relaxed/simple;
	bh=+q1UQrOJ+CPRTDzi0p6Gp12CC5JetN3GLzx0WP+sRD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLDoPWNAIQinWGuVjl/hE5gYRMVNqiKFT/bauB6sR9BuPGz0FfUq0oNNxEXhpf3j7FO916yjF91Kiaw4Wp4xorVXLY0TqEWq58QewBrfbbH3FVnOO/Rp1CJnCncbxPmR4hHsfOtHJBSoCt8x7ysfkCvVPcXYbBVuCI2/Pznx5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9xr8xsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9xr8xsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD9C1F00A3A;
	Wed,  9 Sep 2026 00:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913220;
	bh=GnjhAVP/V30TSMfLwyIvSXBQLxYlj9VOI1IVLcD+S/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9xr8xsPsQajrh7KNO3zQeEHBHiWOotHZ0SrQLVlX2ZYwElLcciKlJZwVz0Tjkvnr
	 d+TRxaTBdCUUQWTQARSgAJPRFD7xNHX+fZz+gvoMyP4urTw/ADH7Sq2s+iqFsaFlBA
	 S5/eWZIBHBJssqlUrv15QhPAS1VVHLGBZG9hjlV3oaJyYNkK/JLcZU7+4oK7SdFpoQ
	 b9wKTHus37Jw4iTqhTW+daFZijKPBRYsnYd9lk3Ajf6L2V4iyt9QC1S1fkLqc0ufPQ
	 5yg04sE+dc931sH6Zyy2MlAlFRqBN3I+t2TPXRrfpF4I2ZySTy9FtZA5xyn4ZmiJHs
	 dKXDsajhL3K0A==
From: SJ Park <sj@kernel.org>
To: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: damon: add script dir to sys.path for PYTHONSAFEPATH compatibility
Date: Tue,  8 Sep 2026 17:20:11 -0700
Message-ID: <20260909002012.111767-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908214238.2680324-1-eva.kurchatova@virtuozzo.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  9 Sep 2026 00:42:35 +0300 Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:

> Running these tests under Python's safe path mode, either with -P on the
> interpreter command line or with PYTHONSAFEPATH set in the environment,
> stops the script's own directory being prepended to sys.path. Some
> distributions (RHEL, for example) build the tests with -P in the shebang.
> 
> This breaks all 7 DAMON Python selftests that import the _damon_sysfs
> helper module located in the same directory:
> 
>   ModuleNotFoundError: No module named '_damon_sysfs'
> 
> Fix this by explicitly adding the script's directory to sys.path before
> importing _damon_sysfs, following the same pattern used in commit
> c3b3eb565bd7 ("tools: ynl: add script dir to sys.path") which fixed the
> identical issue for the YNL tools.

Thank you for finding and fixing this, Eva!

> 
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Reviewed-by: SJ Park <sj@kernel.org>

This patch is applied to damon/next [1] tree.  If this patch is not added to
mm.git in short term (~1 week?), I will ask mm.git maintainer (Andrew Morton)
to pick this.  So, no action from your side is needed for now.  If it seems I
also forgot doing that or you cannot wait for my action, please feel free to
directly ask that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]

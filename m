Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801872E8B67;
	Thu, 28 May 2026 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977850; cv=none; b=DPjoqH/AhCqF+5rZjmA9QVwxeyAqMhRA7WFdD6qx2P9JxX/J8u0A+I70eM07vTFgWQG7OMiIJhaqyBh4p7/sWTWgBoj/dVQDA+d1+00Y91UC0jJQ7tQZW8GjA3fA+bTF0PCUiFHgZKxD6oaKZDhZAkqXCt2ZMP23J8JXFNLbNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977850; c=relaxed/simple;
	bh=MsikhhDxC1TTiZswK6YILmhTMGSdUidLre1XCTXomhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqlK1EmkDKPrKsU5D8TW1ngt84DvoMDNvzrJzGOdXRPxZdZ83AyZplxnUziYieegLxq5f6s+mhP/yu+6PKbZ7Jin2MrPvbR9O5q1XiomR/3Z6aPvfRPEMFMVcNYADdcDdMOuSoUaQ81TwdDCCd/dD4cz+YwbTKBrKuCxsNHmeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEan6pKT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEan6pKT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906DD1F000E9;
	Thu, 28 May 2026 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779977845;
	bh=CDZzB76imM/ZyTMHaFDecVIOSjwi40sCkc2kKFTlUbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEan6pKTVEyYv/2jgbMmSn+yoVd9ZbqtgdScRIZ1HCpcGSMtYDCTuHudDHp/bHRge
	 aUYIYUUd0HfXkKWaYFkhqKSPVdUWgy+Pkr/FptqtAwNZrZHNm0/TAslcF6wUQwlyuq
	 SyRzj7qelEkEsnpSdlnXJpLNohpmi/MaOrVJYSVVuaBB5XrTyUVCNJcj1ADXvEj2c/
	 Vn9X1tykdcbaeo5noSJ9gz0OR3Dl0W8Zpj+1hhMUBLBDWiVyWcrxOw+z/yvIMZGGno
	 WfF55DTaiyni/oaqkrd5zLw748ncTOBb/oc9YckuGLaqHmMsD3BelL8yNHvCisn2Dy
	 y/+NyG+lxqsCg==
From: SeongJae Park <sj@kernel.org>
To: niecheng <niecheng1@uniontech.com>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@uniontech.com
Subject: Re: [PATCH 1/2] selftests/damon: fix DamosFilter memcg_path assignment
Date: Thu, 28 May 2026 07:17:17 -0700
Message-ID: <20260528141718.153376-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9B7A70233DF773F5+20260528081039.1192194-2-niecheng1@uniontech.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello nicheng,


Could you please update the subject to 'selftets/ddamon/_damon_sysfs.py'?

On Thu, 28 May 2026 16:10:38 +0800 niecheng <niecheng1@uniontech.com> wrote:

> DamosFilter stores memcg_path for sysfs staging, but the constructor
> assigns it with a trailing comma and therefore turns it into a tuple.

Nice catch!

> 
> Fix the assignment so memcg_path is stored as the intended string.
> This makes memcg filter staging and follow-up validation use the
> written path correctly.
> 
> Signed-off-by: niecheng <niecheng1@uniontech.com>

From the git log, I found it seems you also use 'Cheng Nie' as your name.  Are
you intentionally use 'niecheng' as your identity?  We disallow anonymous but
allow using known identity, so I'm just checking if this is an unintended
mistake.  Some of us (mm community) prefer real name, though.

> ---
>  tools/testing/selftests/damon/_damon_sysfs.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
> index 2b4df655d9fd..022f0d392204 100644
> --- a/tools/testing/selftests/damon/_damon_sysfs.py
> +++ b/tools/testing/selftests/damon/_damon_sysfs.py
> @@ -254,7 +254,7 @@ class DamosFilter:
>          self.type_ = type_
>          self.matching = matching
>          self.allow = allow
> -        self.memcg_path = memcg_path,
> +        self.memcg_path = memcg_path
>          self.addr_start = addr_start
>          self.addr_end = addr_end
>          self.target_idx = target_idx
> -- 
> 2.51.0


The change looks good!


Thanks,
SJ

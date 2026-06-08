Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7429D294
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928238; cv=none; b=qM/tp/WTfbbM/fYjNBFbqowpwKUYQC9MyPVu1bZ7hEPohR4oULewx13bzl+KtrLiyib4yhjeaXUPWZiMEywyVdwezpiGr6RpWImr6Zr/KXFUU8ZSz4oMEUugg3vOd3iIr7zwhvXgTEZ88XVZKy8KYvMt/cy4L4y6WgBKwUT+7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928238; c=relaxed/simple;
	bh=hI2ca6y3hDlmPra6oOxRf4Zebsjz7gHurGW05JnWV38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfzriq5qS1AFnBYT3cioSezc5y779/tv8q34U/v3aEzYHn4rSDScvZxaCxHQJfnL+yHbEjO9s2uEPBjYlMjOGfUgfZXTebcSP9TbmUsrQiQnSA2a45ge+Qoy/0auEFKGwu/qz0VdOcxYjC2byZhr49K+pwi29ibJmZQM9ZcNhuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsKLqCR2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsKLqCR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24421F00893;
	Mon,  8 Jun 2026 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928237;
	bh=161IXQu5LObGub8qbTPDRf4P3Gx6PmhfcqaUuzWxjJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hsKLqCR2SWgETBqne/VYhd5PgVjHofPoTx5ANGCm5RaOgqSCOFPX6GqBhOqv9dSax
	 2oL/ggBjuP1WnR8vn3g3fnc5cvDUsE01/NqxrtAdpx5tB2NeSrfb101SU+KQyUFQuc
	 pZqBoaaNt7hkrMMtTGr/m7hAb1hxH6C9lSt8ZIF58yVAeN05TCZHfoWi8FAEKhvyy7
	 cRN0Ida4xyfJd0IYGBcbI112Rh0QhlzD3RL8Bvzy1326h9IwkSGCQlh5IJBdBI34aw
	 MLesZKBhiXFaaDnezNgjJ5UyMPwOMFSudmHLFLcX7mD/STU/TwgFWam7rZcxj21sPl
	 s81g6SGvPXhWw==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Zenghui Yu" <yuzenghui@huawei.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon,  8 Jun 2026 07:17:13 -0700
Message-ID: <20260608141714.67903-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608112455.274231F00893@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 08 Jun 2026 11:24:54 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The newly added validation for invalid address ranges bypasses the `detect_node_addresses` auto-detection path, leaving it vulnerable to the exact same `WARN_ONCE`.
> 
> Pre-existing issues:
> - [High] Memory leak and potentially orphaned threads if `damon_start()` fails.

Nice fiindings, but not blockers of this patch.

I will work on these issues.


Thanks,
SJ

[...]

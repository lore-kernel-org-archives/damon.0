Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B731D381;
	Sun, 31 May 2026 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245545; cv=none; b=NsCRZF9aEZ/gr8o7ps4yd7FMGSJkB1OwomVkLordi38c6hgHmTq1gtUWQGsYanUcbCDoSrXn4HSdbd640xF8O7E6IpAMVy5ZEYn0GwBKMtY9TFfUNiZ4X2+aaSZ5MYl3bQrehJho8VPHwiDI8gFnpHDgxJfGXQkuRu9rQ/q/I4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245545; c=relaxed/simple;
	bh=rQTAJwkhZy+WezbWT4s8/noxy8j8s9Juzr1S8yD3uHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlRn1kIhO/SPwpRdyW8Y3ZxfRrD7Xc/BOau3hcxaHxvDREs2cznBOku3KmmOYhFhDuCA1SO7Ck4usZ/l3zkDiEUv5lI8sBCw4vXJvf6X0Zy337dbEHP4qK7WVUDV1v1m2kjYEOQllscBbuVyMhD8dEFRk+r3BAiPTI18BwOn1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJq04HL3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJq04HL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925311F00893;
	Sun, 31 May 2026 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780245543;
	bh=XObA2UMxNmwwA42Wy22KZAaxCp9zZ0vzc8OHq2Dq5MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hJq04HL3vQiJINojn4UPi/GlrwiB6abd4pbsMxQMxO5wA7sovcbyUeYJvjZMRgPou
	 zObxP9gbaguD0LJwY8/jhJLdNezfFUGyglsFPZOt9I3jnz8SWuMIKzkLJaL39oDCTB
	 KjDwvOKNPde8l1o2eKI5r6ZMT49MCKr9JbHAx1kb6+Jf+tCWs4fnlW6/F58B9f+BJW
	 J4U5Vf6X2Shn/UU0f4MdjzvyChTN1vYh3pVaXHP4iLrXeBFCQUDOQxTTo9Q5/5ere7
	 oeAvHmL++h2mOylMCufG6+vQhwD7IxUV7Cw1Kqq5Te5Amo2beV0oMMtUDHSHHg/1nf
	 LPpexWTcuEHjg==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH 3/5] selftests/damon/damos_tried_regions: fix expectation output and join TypeError
Date: Sun, 31 May 2026 09:39:00 -0700
Message-ID: <20260531163900.99184-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531091724.84381-3-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 17:17:22 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <kunwu.chan@gmail.com>
> 
> The expectation print has wrong operator precedence: '%' binds
> before the conditional expression, so the else branch prints
> 'not met' without the prefix 'expectation (>= 14) is'.  Add
> parentheses to fix it.
> 
> Also, '\n'.join() on the list of ints raises TypeError;
> convert to str in the list comprehension.

Nice findings and fixes, thank you!

> 
> Co-developed-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Wang Lian <lianux.mm@gmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

checkpatch.pl may warn here like below, and it should be fixed.

WARNING: From:/Signed-off-by: email address mismatch: 'From: Kunwu Chan <kunwu.chan@gmail.com>' != 'Signed-off-by: Kunwu Chan <chentao@kylinos.cn>'

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

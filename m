Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56681922DD
	for <damon@lists.linux.dev>; Thu, 14 Aug 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188913; cv=none; b=AlfcvW3/ThqAN7rePh+V4rrBBLicjSTg9iQVRW/GTZqWdXwgbv8jk/9XMTE4ls6JeP0KeVhhyIEWF1dwRE44IwkSnSVa93RwIaZjIX58/j15zy62JG9xgYaLk9w1PXUSvoZwKdQSgqqT/+SkyT91Mb+6Ti9s5etF1nJKUUckvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188913; c=relaxed/simple;
	bh=qqqqhwozdCdum/ULbTBpHpXIETkNzrqeHLjyeJRP7wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NWtUF2eG3qyYAMzv2ptnvWGcRpT6KveMQYVGJgIY7yRpT9VdrcOD1QX95u/egwOpbuRLye+/ml0JTiOOLVX4Ajc4czIi/t4LocWUTzsq2MmVXSby3YstHrgfNhEzbRimRvYlIi32wne1rCELKF8J/XLvVAkQeKpjVUZYUwNnh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BweFnuNU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BweFnuNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CB7C4CEED;
	Thu, 14 Aug 2025 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755188913;
	bh=qqqqhwozdCdum/ULbTBpHpXIETkNzrqeHLjyeJRP7wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BweFnuNUx8YnFSQn1f02ZMTNu32wJoIroLq+nRjjVcGtLqQU8QI+s4xxqbMwLNk3M
	 CUFJXCCVM9bWcYzDUXKfIWlzJ3mLdi76diaYMPzPbQsO6GTtVLV53/cSLbkDQ8WlO2
	 edpWZ7q7OwLWlgVOG+qI/dFuU340KYcgkhYaB9eaB9vEQtJ+ZAOt6KxJPqHxTPiwIR
	 d1+M1IPedSwcoGLE6N4mOuN8fYibmnPeEN8faLxeiQ56c300qjvmBCszjF41j/OiIY
	 vvDMSNqHMpa5EZbeRNwjCoiqYM+/HfV0ASBpeFPdI5ewcXKiU63whhTRdNVMCzfVoH
	 sNhkqG3eovwMA==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests/damon/access_memory_even: remove unused header file
Date: Thu, 14 Aug 2025 09:28:29 -0700
Message-Id: <20250814162830.69820-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814125417.659937-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ Andrew

On Thu, 14 Aug 2025 20:54:16 +0800 Enze Li <lienze@kylinos.cn> wrote:

> Since the time.h header file is not actually needed in this code, we can
> safely remove its inclusion.

Thank you for catching and cleaning this, Enze!

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

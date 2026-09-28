Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECF0480951;
	Mon, 28 Sep 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584809; cv=none; b=WN2Zq1LwUaj4zQ44L5OundnF3kcvvZH350nLYA1oOa6+zAFo92f15DcJdbRh0802BN3+zQqf8yyRY8aUqLxztaa6IAZE6tMnSDFrnvrfA56uEYWzFsH0MJl62xjbDY1mj3KR+UlSNEUtlVFgfl9gRcopTEeFluFodElJkgUCsuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584809; c=relaxed/simple;
	bh=EI6USUQ8jlxW8IJ45Bf07Gm+h1ulLVFmdQTepG0Dwds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bomGcCnscsbRtWQTtuQ2lZ1/23U+8u6vvwpeIT1BaW6Yq8R7K5TEyEfnbFuBs22sra/pM2X6USefNG2TOKD2K0upsTaqj4kYMWdNWXvO7lc+jlzvvNp5ufHorYbrNaxwDq7HUbpt4mwbWswqYqp19dL6vP4n8ihrRO1JA0JC2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9jAARX9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9jAARX9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4663E1F000FF;
	Mon, 28 Sep 2026 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790584806;
	bh=luI3cyiFOxUaGqTjp6wOLnxw6rfD0knECSRuoDaIkvE=;
	h=From:To:Cc:Subject:Date;
	b=b9jAARX9b4abbQnaQJg5hLkdK3FfaAc7TIbNbQDri1SX+IyOHh/xS5XU7rLUL0ZxY
	 Xk4EJKOQLMGmkqxZoOxUc0SJRw5YSAgfAQQ9dTuypJgX9Z534jyCgD6MbHVXzXgPgD
	 EfUcxueugy+VOpFxumshq0yaR+ltZ8W6FPEdeC3+FP2oPUIkY22Cbn2ck/MyGXLGyr
	 AR1fUn0guVbfAQxS9dslnrqXFCYHnRTVxQxk9/Vi1uOuOcW7G7m8vniDWjgqYcx+cO
	 Oc3WQOAm1d+8GjsrPBmfvchSY3YMOD0Nsg3fZ/4qtBQKSvqvGq8H40T973DbLixDzc
	 7Vk4VYNodUhPg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Justin Stitt <justinstitt@google.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/3] mm/damon/core: cleanup code, reduce stack usage, and add kunit
Date: Mon, 28 Sep 2026 01:39:54 -0700
Message-ID: <20260928083959.4030-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three various improvements.  Patch 1 from Zenghui Yu (Huawei) cleans up
unused enums.  Patch 2 from Arnd Bergmann reduces kdamond's stack usage.
Patch 3 from Karl Mehltretter adds a kunit test for uninitialized PSI
quota goal stage logic.

Arnd Bergmann (1):
  mm/damon/core: reduce stack usage further

Karl Mehltretter (1):
  mm/damon/tests/core-kunit: test PSI goal values with explicit samples

Zenghui Yu (Huawei) (1):
  mm/damon/api: remove unused NR_DAMOS_* enumerators

 include/linux/damon.h       |  8 -------
 mm/damon/core.c             |  9 ++++----
 mm/damon/tests/core-kunit.h | 43 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 12 deletions(-)


base-commit: 9a7b617f9c0b3cc653987c9e6d0434cf1079130f
-- 
2.47.3

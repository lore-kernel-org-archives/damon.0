Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344F53D994;
	Sun, 12 Apr 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017658; cv=none; b=s4GQcBVZ135p59T12OWESEK59MmYYoG2vtnxihpdRXRMeYnuF1e7eaNgL2S06IuVsl3C5L683BI4+u183T970QRQFvt+kuQSYiKd670WH0YlG9nCbT+uhExRNCEHYiZQ5TrZOayUxaKbnaJ37pbwdCHmxV0Q+R8LVzGFUPA64o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017658; c=relaxed/simple;
	bh=ScWjFfjjpM9jn/WjFwtS9xJ95budLw+WQgu9N2i0yr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftkbv5GOzfdYdeLlgdZUykbcldMGoDJA5pCxtCy7tITtphvnUGbD0DeKakWPvoiAHI3jfjQ9lYBNaFKcZ5ieov4cp0r+P7wLgDIzoY5LYfyulDUJkys2hprsbuzLb6wvX+sP8nvOMGN60ucpXTmKtpzO/iOPT2zNrYPBFSi74wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAskbK8U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAskbK8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A148EC19424;
	Sun, 12 Apr 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776017657;
	bh=ScWjFfjjpM9jn/WjFwtS9xJ95budLw+WQgu9N2i0yr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PAskbK8U63j7K2gYgh7JPEvRyPtpkqPh3JB5rKqMB8MZPYFL8RinP/tRLYZXW16uN
	 V0FbIjCqRcoPGj1KzTUTYV7UlWk1+t2ckM/jWKfsB9G42Ch6zxcC+qvQ/9ezf2Tj8e
	 1/Dp559TCBynLYestO13T/2x+IK3xuYguT2bPuMz6/a/HkSczEiGEhDaKoXT6H2OGl
	 YrOphXq6Zx2vdI9p+YUAin65/pPDdhCz45nLhMfJnzEP44rmn3GhQ++uM9UFAO/UH4
	 5mhfq0oLiGQht+RUCnwUr/E07RMhlJ1zHeu5ZTwusynQVITzDXcmloyHDzqlWxbbOR
	 1B/4ZhI6mKw5Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [RFC PATCH v5.2 00/11] mm/damon: introduce DAMOS failed region quota charge ratio
Date: Sun, 12 Apr 2026 11:14:14 -0700
Message-ID: <20260412181414.84422-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260412161957.82835-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL; DR: Seems Sashiko is finally convinced.  I will drop RFC tag from the next
spin.

Forwarding sashiko.dev review status for this thread, with my short comments
for issues-may-found reviews.

# review url: https://sashiko.dev/#/patchset/20260412161957.82835-1-sj@kernel.org

- [RFC PATCH v5.2 01/11] mm/damon/core: handle <min_region_sz remaining quota as empty
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 02/11] mm/damon/core: merge regions after applying DAMOS schemes
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 03/11] mm/damon/core: introduce failed region quota charge ratio
  - status: Reviewed
  - review: ISSUES MAY FOUND

Sashiko is asking a same question that I already decided to ignore.

- [RFC PATCH v5.2 04/11] mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 05/11] Docs/mm/damon/design: document fail_charge_{num,denom}
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 06/11] Docs/admin-guide/mm/damon/usage: document fail_charge_{num,denom} files
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 07/11] Docs/ABI/damon: document fail_charge_{num,denom}
  - status: Reviewed
  - review: ISSUES MAY FOUND

For this review, Sashiko seems just hallucinated.

- [RFC PATCH v5.2 08/11] mm/damon/tests/core-kunit: test fail_charge_{num,denom} committing
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 09/11] selftests/damon/_damon_sysfs: support failed region quota charge ratio
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 10/11] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
  - status: Reviewed
  - review: No issues found.
- [RFC PATCH v5.2 11/11] selftests/damon/sysfs.py: test failed region quota charge ratio
  - status: Reviewed
  - review: No issues found.


Thanks,
SJ

# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --thread_status --for_forwarding \
#             20260412161957.82835-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

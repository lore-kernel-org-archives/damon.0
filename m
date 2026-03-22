Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9A136672
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215811; cv=pass; b=CO+XysYGE+KQlurbuDj2vFHUcQ5Us68+fWgmSjyt282zAkdv0caNK1oZhqwN27Ii/tAoKZITRKzbvET+ai6Xnp1X72Y6Ecl5vynne6MtgNbOFd3uW/bA8Ps5rCl4gq6lw+eTdmgyPqVZJU3cq+5rqY9GZihC18lFIwM6SyWFN5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215811; c=relaxed/simple;
	bh=omstR4d6ty8j/p16p/N3K3FUNDAVzMwhpCtiLu3JTWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjlG7BN4//+0NVAugbFdQQvPwBiFM+bcvTZ+BG6IXXbgbOFARJok6HP1OfPScZfoYUoSjHcvp6/yuyikoWQQSA5eeKJg7WpktcwrSj695QUreHekBQpxuOkLqvzXqjkJ2B4lO6ykU9UHfPmfYlVnkYspw8MKI748fBy3B/xQ1Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=VFViA9ye; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="VFViA9ye"
ARC-Seal: i=1; a=rsa-sha256; t=1774215806; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=G1FORsx21FlaLlrJlmWEQOWMt8Qjsww9G/CXKr/bP6W68g2OGSr4As1pYzn5ZG+ogj28z3R/jWjEFbfYKCgom6+QnKby7VSyyGJ02DN3I1CCyVbPRHpTPjXJMS8Gi+jqkMq684QSCf/KbEQSGVIUcWwlMxqrHwHvjqlmwDNGdSc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215806; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yd2jmjR07bIuf6kL6KzUQ4C2XuJusyaCQ+MvK4c3VRI=; 
	b=jok2fEBgVv7HZ3ICJcOKbz+7mIy3BfiZzUvbnEl83mJnCTJG9Ilu4o9PyhfBkQr1rbuu8vA0eziThl4Bfe4gh4XBurLToAVPV0or02mPBoSfYZKaabOH00b3aXxVYz8ZSf2qrb24Zzx3ja8dCp58RkTrSQFTSpnpT0SqvzpOJds=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215806;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Yd2jmjR07bIuf6kL6KzUQ4C2XuJusyaCQ+MvK4c3VRI=;
	b=VFViA9yeCN6ITvIYwQ7UNJa96wS70A7og/Eadhz2z8GGXbw8/mw7Z1d/neqFY9gv
	yfpASvJ272WutR9I2t8yUNGFdFWc3Mz2tBiHvTD5OqNQuFVYJkRpfSlnq9R5AxKVwx7
	Dru5aJ8jUPqelQbXA61n0RLgjqjboHenlJ8W5RI8=
Received: by mx.zoho.eu with SMTPS id 177421580593959.57310327386517;
	Sun, 22 Mar 2026 22:43:25 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 0/2] mm/damon/core: Performance optimizations for the kdamond hot path
Date: Sun, 22 Mar 2026 21:43:23 +0000
Message-Id: <20260322214325.260007-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello,

This patch series provides two performance optimizations for the DAMON
core, specifically targeting the hot paths in kdamond.

The first patch optimizes kdamond_apply_schemes() by inverting the loop
order. By iterating over schemes first and regions second, we can
evaluate scheme-level invariants (like activation status and quotas)
once per scheme rather than for every single region. This significantly
reduces CPU overhead when multiple schemes are present or when quotas
are reached.

The second patch eliminates a hardware integer division in
damon_max_nr_accesses() by using the pre-cached aggr_samples value.
Since this function is called once per region per sampling interval,
removing the division provides a measurable reduction in CPU cycles
spent in the access rate update path.

Changes from v2:
- Fix multi-line if statement alignment in the first patch to satisfy
  checkpatch --strict.

Changes from v1:
- Use min_t(unsigned long, ...) in damon_max_nr_accesses() to satisfy
  checkpatch warnings and improve readability.

Josh Law (2):
  mm/damon/core: optimize kdamond_apply_schemes() by inverting scheme
    and region loops
  mm/damon/core: eliminate hot-path integer division in
    damon_max_nr_accesses()

 include/linux/damon.h |  3 +-
 mm/damon/core.c       | 68 ++++++++++++++++++-------------------------
 2 files changed, 29 insertions(+), 42 deletions(-)

-- 
2.43.0

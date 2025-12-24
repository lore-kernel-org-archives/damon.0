Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192D30FC16
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550136; cv=none; b=oXMmueF4dzKmLuP1XfXmqADy/W3wAwzfLZ45rfzifFIgvG7F1lZIvej0fkjww/kIsTSsSZ3pvctODlMXpaaXAA12W/s6IeDMuPSNxL90ikvldT3vNBsqVvk+rQJDlqlOggpt8PZd1DigoTtLbz9nX84vaPfHFkNCbI4opyhWJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550136; c=relaxed/simple;
	bh=sUvHXAAy2NQuKc3dI2aHwboqObqMXx1eX5Kl9qq4xI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TnIBvojOHqWWNryyomwOigzvJ49sW83gI6PkQnWEvnr6EFvdpFdMg7Uf+kqEnhQ36FdRF+SbECJ+QA5Ctz4Dd9zd1fyWaBtQhKa6mYlY2x5+seVDv02K3rWXmvVFO7FugNKjBbNDd9v1USIE0hS5rJO7fsgFaRp9usVvG15mNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV6038CX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV6038CX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29f102b013fso68851805ad.2
        for <damon@lists.linux.dev>; Tue, 23 Dec 2025 20:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550135; x=1767154935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+TGrPuT2v1cZj1mmHtKJ1nXyGxXS49Cs2xA/DQGK74o=;
        b=BV6038CXPxQFAc7bt067jJUVrFI9mMe/tMPWKMH88E3tTxKiMYAdiaV2lvmEPwsOnY
         G5BKfuVRJzVrmUGOff/EGp0heQXkCoyQzQi+2WUj0wWHsgJRGMvOgck+k7wpeSeXsXw5
         Zq8iPOuu7La+3Yv9hwlAIvRedAuWXyRq4T/2YFfmcyqd9ZdZTZNJHSarY+EgrnYbkLxI
         OGNzeXU2QvRt/lhmfcF7aBJY1ETWq9srXw9JKTBgU/UtdZwYE+AgxHKhOCU6bcAymU32
         fI/BcJ2/EcQ6EIQSqlsaEKGHnQjmYMLbzzDaOmnzJagv+uyy4qYFDdsnj6qrxOhj5Ilf
         9hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550135; x=1767154935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TGrPuT2v1cZj1mmHtKJ1nXyGxXS49Cs2xA/DQGK74o=;
        b=S95WXWborRvL8puXZ0l8jdz5n+X79emXfJQYmPGEaTLTx46b1zKDtpyUTOKX4xGKCg
         eoUYZFFuvkNw2PiqosnIEZtTgz3yN6jklyUkhovfirdVyoAE0H2VBpOsNSW74CPA4Cqy
         HtlE/HT3xvAYE3ZM1Cwg3dGYla0rZVoRDKI5t8XZZ8ni498xEXs4+gzR75S1+5rU0NjE
         6TS1OXd9q5P4eUI1m3DoTXIHxSyxAXVaMdo7ukO5e0hfukRzY8wP5jVDYKnszAvdOxxt
         DoCLolv0OONlBAiCmxYoT0BtdBe0TCuPUPsM9lW35ptIv1EHqN11zavsaFkTZlq9TsCe
         0iBw==
X-Forwarded-Encrypted: i=1; AJvYcCVCiB5j94T/cII/9hWf3uGo00uc7B9eBdfJJj12bhBKkDZhal3qTPfWs5pAuvURdBy54feLzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgllHBGnqoBBvis7m4uG+jmLGydHWLRtAgF3Ivou3l0CIILzPF
	LiXC1YTFqNL5st7LaOIWRnEKKqDuAbggf6VQlyceQMRjcguFdhniH+WQ
X-Gm-Gg: AY/fxX5tTIAL2cU36xhDwVRnnsgr8dNjL3VaO3fmJ/z3yJZWSH21ji0l7OsBmRiEHs8
	UnVyMQKhFBzmm1DOO3inhLa53sCnY0s/WCCOFCQeeNfDt5FBnXN6z+HsBT5UoabUr4KprpNguIg
	rQeRZgFkwFP5NoJV1BUTGutw7px77Qdag2A7yjNKJXEfgRgn4JAfxV4bLyiNergCEyB414v9QwU
	gc2WU3RU5jm3JLSiPe3YlLkQGgS5szQ9rDQtVUymeBLx45Qqy5+4uxDUfka1+IngE9ZvP6d4v1y
	m8aZIr8fgjRvPFzwja22jH6zCKnJDUA9rqJd4j8urwes7jJhkeQXitgFCsvskbf7TdjxoAr0Css
	TmTp4aa5WBt6rSrPjJ9vkIwghJRRa6Fl9xpu4nfzwG7eSx94buci4M6lrnHGdUEkc8kxMnK6Zw0
	Y8
X-Google-Smtp-Source: AGHT+IHOv+s1tLvmzhpsyvu7LJTsUAsXFw9q7TcmS1xRa6GeikBeK5vKJ0t6dCFNR8dYeCrV/OJTzw==
X-Received: by 2002:a05:7022:1719:b0:119:e569:f609 with SMTP id a92af1059eb24-121721ababfmr11396994c88.2.1766550134622;
        Tue, 23 Dec 2025 20:22:14 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm48542031c88.8.2025.12.23.20.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:22:14 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shu Anzai <shu17az@gmail.com>
Subject: [PATCH v2 0/5] mm/damon/tests/core-kunit: extend existing test scenarios
Date: Wed, 24 Dec 2025 04:21:55 +0000
Message-ID: <20251224042200.2061847-1-shu17az@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the KUnit test coverage for DAMON. 

The five patches in this series respectively extend damon_test_split_at(), 
damon_test_merge_two(), damon_test_merge_regions_of(), 
damon_test_split_regions_of(), and damos_test_commit_quota_goal().

Changes from v1:
- Split the original patch into five smaller patches.
- Remove a newly added region from damon_test_merge_regions_of() 
  to avoid an obvious test case.
- Restore the test case in damon_test_split_regions_of() 
  that was previously removed.

Shu Anzai (5):
  mm/damon/tests/core-kunit: verify the 'age' field in
    damon_test_split_at()
  mm/damon/tests/core-kunit: verify the 'age' and 'nr_accesses_bp'
    fields in damon_test_merge_two()
  mm/damon/tests/core-kunit: add a test case for region merge size limit
    in damon_test_merge_regions_of()
  mm/damon/tests/core-kunit: add test cases for multiple regions in
    damon_test_split_regions_of()
  mm/damon/tests/core-kunit: remove a redundant test case and add a new
    test case in damos_test_commit_quota_goal()

 mm/damon/tests/core-kunit.h | 50 +++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 11 deletions(-)

-- 
2.43.0


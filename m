Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CC431A44
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907067; cv=none; b=e63OKQ+3nz8EuUpi68uh6HR1q8DGK0igtKuYXd0j1rrft3gKjqpNlp4x7S4dQlBGAKzfyheWgXAm/tU5c0tGGVd7hSANq662r7vm7B/M6JZfzDRHsycWjzZq991UMdKgdu75id9GAAWE7D0mzJuyztTpte14YNuDVCt9d6oibRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907067; c=relaxed/simple;
	bh=2z8zu+W3cq9IzkZqsMaIfcM1XyWPibcdAlGiXD77Nmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hX6DEPXtJ9LeGDy0DY2z3TtuRjfFZh8peU7cT+L2AW758/x9pxiaKJE3qJ4YSSqCKjBRe7H+2Y2vedK7aDSO5S83BxO6W1+0V+VTlmqV/5HqzDVd75kEgWXIWsIb2xzUeyRPuDgDhAG5V6t0DqzOlwz2DTEtfhL43kJI0GOfNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffrpdq2L; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffrpdq2L"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso2229409a91.1
        for <damon@lists.linux.dev>; Sun, 20 Sep 2026 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789907057; x=1790511857; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xjgh5OlWwYGa3/r9MOFyxfKxsWIa/znQ2EXAbXuSxlg=;
        b=ffrpdq2LfSn3yYTMlE/pkIVF8xUJlDwajGJDLGqFrpMlQjvbNlYzRtJDlX3ZgOyLDT
         Xcc6dnbFOplenNvK7fd/npqHb1mojqdwcZxftcwWE8SYb1fciZqt7V6JJOckaTtlvUES
         tUcD2osmPYG7VzZkrt/SWOU8EQ5Pm1P4n2VTHJKuJwQ/GkjVxPJkpldYUp6NudpLFnQ6
         0YY7yitVJqWIwjdO88yVXkBM36Kll2NuHLxpp9yry0HaSIa6tAFYnuDfsU9QNvL3jtcp
         Amg2Nx+2o+dJM1LkLNs3AxxEGI9WHwpyqFOgIWDeDZ5QeBMK5FNlBRFIsRWPeuHk5Wqg
         eKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907057; x=1790511857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xjgh5OlWwYGa3/r9MOFyxfKxsWIa/znQ2EXAbXuSxlg=;
        b=jq/Rgx6qvjyWBmy3A99e/P4XEy8wMHMErJfKgHbyduiNn+pHaEYBHuFKUKpqgjM8q5
         VvaUfTe4JU1jw+CWQfb7gUDVwDWfgI0qStYdnipHkyibjzmO4Kzx8tCP+KR+i2tPDZYF
         mifL/ryFrzAfWNeiHdIGixP1DBtAJysKF1TMGFAXvrm68AW2uyEZXlQlrPef/ZVpesJQ
         AQUzbhGuIoKZRJGZ57AYoTDmLQ45m8ZZhOMiu6EQJhSrUQOQNIN4rM/BeNe0WNYDaxNE
         cX6rmRh+2NWiG6IwjuomV1mISI31xbbhhxALo+c1LsTvTP21b5Y8YT0z4ClsFmLCUKpj
         6PFg==
X-Gm-Message-State: AFuF++nWn9VmEPhajtVc1TwOh4A6ZGTODQR6ZqK6yI9tXh6VkTIzj3ZP
	foPvIguAJnQhmI14tCHQW3vVxiSH6adV+K47tX50LP0E2zgZT25w3mc=
X-Gm-Gg: AYBFou2iseO3GUMsgjwwvEOfPfAEYLATakAp6K5bQiAAzWqn0atrDbn6zhPiEFRm9ZB
	9KjQDxrOh59SOwK2OWa7bWSccr3UYLlZyt8O51qDIEHhx0UXWieRGE3uI00ZUZeNpApYCxBh9MI
	9ShU3WrPumz/jk3ZgsigqCstHib2Hnr/9i/rC2NQQR2SzTwWKUrH8aXK2PRoO/Do+dK1CPEVdy4
	BHQ1kch/VE7A5TIrZnBJo7/pF0YmpMiFGy9t3JfiN2DLJ+8oLILkwU1qXW+RnE5hZj7fjLl2vW8
	KbJyJ37jhQ5/+j2iGShX1bXu2dVsUeBGjm6kkmlEsra70DCrJiUygpL+KHj+02GGCZtkD3+DVP7
	lZUqUimcW3pGBMn+ZsFA/DyPLA58o4fdbhuAp4PHgIoK+hxFIs8ZXuZoTbDiqGg+qqg0N6pdzFp
	GWfWowcI8H/9lXeMCHK4QtddDYzrdWBYOB3MSdC6lHktzRcpWfWeCTGNdCy9+3HcCUQGLFPNxMh
	HmXKU/OjzbH/+1bkTX1cqWYHvU=
X-Received: by 2002:a17:90b:5784:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39e54f35b9cmr12927548a91.25.1789907057067;
        Sun, 20 Sep 2026 05:24:17 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cae997csm8753943a91.11.2026.09.20.05.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:16 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v3 0/2] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Sun, 20 Sep 2026 21:24:09 +0900
Message-ID: <20260920122411.610213-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() hands the size quota to
damos_set_effective_quota() through quota->esz_bp in basis points, and
the multiply that gets it there is unchecked.  On 32-bit it wraps above
429496 bytes, and to exactly zero for every multiple of 256 MiB.  A zero
effective quota makes damos_quota_is_full() true on the first test of
every charge window, so the scheme applies nothing for as long as the
goal is unachieved.

Patch 1 bounds the conversion.  Patch 2 pins the boundary in the core
kunit suite, where it would fail without patch 1 on any word size.

v2: https://lore.kernel.org/damon/20260920023111.2466265-1-donggeunyoo.kernel@gmail.com/

Changes in v3, all from SJ Park's review; the code is unchanged:
- patch 1: wrap the changelog at 72 columns, say what the impact is and
  is not, fold the 64-bit boundary into the trigger conditions rather
  than arguing it separately, and drop the passage on why widening
  esz_bp is not the fix
- patch 2: wrap the changelog at 72 columns; pick up the Reviewed-by
- drop the documentation patch, which SJ asked to drop

Rebased onto mm-new 87acb5b914c2; v2's base is no longer in that branch.

DAMON kunit on x86_64, on the new base: 36 tests, all passing with both
patches; 35 passing and damos_test_esz_goal_temporal failing with patch
2 alone.

Donggeun Yoo (2):
  mm/damon/core: prevent size quota overflow in the temporal goal tuner
  mm/damon/tests/core-kunit: test the temporal tuner's size quota
    conversion

 mm/damon/core.c             |  2 +-
 mm/damon/tests/core-kunit.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

-- 
2.53.0


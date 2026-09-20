Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F73B9D8C
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871484; cv=none; b=Sl8XUQTvcaVTmiGDoGtgUNT+MmCvoewmxxESj0PS8h3UOuKhH+q4FdkaW75LdSFbApKAtl05bcM2XdBUEglyRBKtwkGsrVc9Q56ifLVbQ9kM/Aq/31GqM0EJ2jC7ZFYM+EfROopRLBbPLGhzpHFeVceHsvAu+vyy8Pwfi4eP+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871484; c=relaxed/simple;
	bh=Os70wroAkyQSDifQeYgJAUQ+cY5T25vbjX1a1oNeruY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIiubw8RPTwWXri9qU8tSnpJ5DYT4GANn2mM4YybjjgWIPFRDHZHkj7t8+r5J3looW2ByH4E87rCKC6k6F8G1uinF/CemscPkUH4BIVER2KcG8j4z0FrGGkw9VbJTOZXBf/teWbwh5XFeg+w+BvicZDRCNwpX5e4VO5ALDOGpk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFuJSDTM; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFuJSDTM"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469a3490bso2083521b3a.3
        for <damon@lists.linux.dev>; Sat, 19 Sep 2026 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789871477; x=1790476277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mVeyuR2cIR+fQnzLXyObLYbioaeM21VgFPAK73XbXwk=;
        b=IFuJSDTMIweAYq+YO2/Xf4hW5ASyCwxMMDJCFt6go9dTWUzQfmWpsksdBYCGtIXBR8
         YUs2YjhKNycpWxCg40ahTi/P8zsjdmy6EDkbcqKt+0hEfJNpHQM7vCqL4Pu6HP7P5Mpr
         d4bs5ntN9EcZWL/zJmlTC67wKsGmXPlVLs57CyN2qJbzZ1kpKdtRALLzwEGWvQlkztkb
         DSzLl8MURBR8FMmpQ7yIPBp5GX3RjrdoXb8yt+K/pbHUc6Tle+TsdIdpWQ77Ft/vzv3g
         gyrFwWaWc1GI9mwFfija2jHtzIAjZT+uh0j9Pvar3EcNxvLYpk46TVzd78cilMqaP6gd
         j79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789871477; x=1790476277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mVeyuR2cIR+fQnzLXyObLYbioaeM21VgFPAK73XbXwk=;
        b=UJZQmzneu6IvRaoqgbAf2V4+1g+rzrBjos/MsKwN+vkxuyzXBU4lxFA5rv0yP4hcwz
         f3SNy96ulVxM8wUbYRErQJLaUP5ASVD2YLPxOKkErYntvvxU8BCXA18BbvjRs9ymVyE6
         8hMH5ezO3NFSHhzORx9DIw2yQfEqoGAdPlQuXBH1cSNuygMV/BAYKzZAjTKJDrfVX80o
         rkA06hg2OpAa59Wn1leJCSEg9k4QNlAO4LdTzujfF7vOTqERfT+VlDOByJIuFhb/TFcB
         KVcb+hzsQOCyfuWB+U4NAm8lZWqnET3ETixGyUY+c+0OScbxOyGkjKjzqf5FWikG4vpY
         3ptw==
X-Gm-Message-State: AFuF++mtIKL66vFwh6bL38N6DLh72UtBxzdn3E1To+7O+4SEEs7Qs+Mk
	2/iK6gtSrtDXEYHawgDKRVlfi+UBnhWlsqZ3p33eLfFcX02fhqTPpwk=
X-Gm-Gg: AYBFou2upBhi6BnQxvOfnguRMSjVcnpRyzl3ASGD5cYqeJ+u33czoaU6gdKzrEVx5wH
	KzRvC0HCT1NqcQv997XaK+Ny1F5Hldjcs+ozJJWMaClCNSWwj9+ucu2wnZW2rMmIsSKnbtwFHjo
	dxXfVE9rpYZtYbQGcQYeTPfUWtgR4y34SKCBqLeQ6IaeXBxB0KPMUpZNJo8Bigx7t21Y0gukMIB
	9SbWQaxTlrah9ovJl+d2M1ffduHYs4xcGHRpHdCm3BJif0gGYPMj7yoK5FJUSInCDXTcWItTMXY
	xsECw8pSNI7R8Mm8Z80GCMJUJYUHFEW4xVH6KVAh721E+wzmXa/2f6Tnvrlm9p3spJEIpkFjUCB
	BapR+etsyoFlHVyKY4mTJkcKWAd2J16V5DhgZy/LWDWVrJtNepAIL2IgXmhWy3DJE9NIGe+6NGt
	WYkLxOTnLnhl2l7w2GBndkAq4y/NRPkNUFk+PP1QqrWe/Ne02hUfbUHieGL2aaUW/U6NQkhouYd
	3AVYlC65TYRzkDhBLM2YrKwlQ==
X-Received: by 2002:a05:6a20:7f8a:b0:3da:b8b4:91d7 with SMTP id adf61e73a8af0-3dd8c3fdedfmr11656400637.2.1789871476608;
        Sat, 19 Sep 2026 19:31:16 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:36d8:54a:e0bc:3e5e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72aee03efsm1481341a12.24.2026.09.19.19.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 19:31:15 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH v2 0/3] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Sun, 20 Sep 2026 11:31:08 +0900
Message-ID: <20260920023111.2466265-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_goal_tune_esz_bp_temporal() hands the size quota to
damos_set_effective_quota() through quota->esz_bp in basis points, and the
multiply that gets it there is unchecked.  On 32-bit it wraps from 429497
bytes on, and wraps to exactly zero at the 1 GiB that
Documentation/admin-guide/mm/damon/usage.rst uses as its example, since
1 GiB * 10000 is 2500 * 2^32.  A zero effective quota makes
damos_quota_is_full() true on the first test of every charge window, so the
scheme applies nothing for as long as the goal is unachieved.

Patch 1 bounds the conversion.  Patch 2 pins the boundary in the core kunit
suite, where it fails without patch 1 on any word size.  Patch 3 documents
the ceiling that remains once the conversion is bounded: the basis-point
form cannot represent a size quota above ULONG_MAX / 10000, so a larger one
is handled as if no size quota were set.

Changes since v1
(https://lore.kernel.org/damon/20260919071324.1583280-1-donggeunyoo.kernel@gmail.com/):
- patch 1: bound the existing multiply arm rather than reorder the two
  arms, per SJ Park's review.  Same behavior, one changed line.
- patch 1: address addr_unit -- it mitigates but does not solve this, and
  the 64-bit boundary is reachable without any scaling.
- patch 2: build the scheme and the goal with damon_new_scheme(),
  damos_new_quota_goal() and damos_add_quota_goal() instead of a stack
  damos and an open-coded list_add(); drop the max_sz local.
- patch 3: new, also suggested by SJ Park.

DAMON kunit: 36 tests, all passing with both code patches; 35 passing and
damos_test_esz_goal_temporal failing with patch 2 alone.  DAMON selftests:
15 of 15 pass unpatched and patched.  They do not reach the changed
function, though.  A build with a print at its entry stayed silent through
all fifteen and fired as soon as a scheme was configured with the temporal
tuner.

Donggeun Yoo (3):
  mm/damon/core: prevent size quota overflow in the temporal goal tuner
  mm/damon/tests/core-kunit: test the temporal tuner's size quota
    conversion
  Docs/admin-guide/mm/damon/usage: document the temporal tuner's quota
    limit

 Documentation/admin-guide/mm/damon/usage.rst |  7 +++
 mm/damon/core.c                              |  2 +-
 mm/damon/tests/core-kunit.h                  | 48 ++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)


base-commit: 498ee28e5ec4727f829507c4a1bde3ab1b7704cd
-- 
2.53.0


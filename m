Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A4305E32;
	Tue, 28 Apr 2026 01:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340074; cv=none; b=SiSZE40K/VkbsAwpBn5ukcsAN/3wkaquFdXnToSHB7senFZEhforZCRH9YsfmX4hh6znjvA3HD8Eg876Fc1qr4KdIfOw65elEMHArhaAYXf3TW7XemZZaSHDNxsXPmPmGI9aulr0Ggiv1cGSstNBSZl2XyvO8QFea5H0x/GeeJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340074; c=relaxed/simple;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQpLVYIUuC9NLl2jJ3QD195y9u0WBKJr7HeJBT/FnuZlvMLqcLlnjORJAy0mX8e8/eSlQyifnj5GmXaJ6oTIygUrzgmFKEHpC+3iutdovEmr49ryVK8N77Fq+bCFRiMusRuYYs2a+ILPvwIz/E221jWcNnCI+jw8qwl3jkgG5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3wwXZDm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3wwXZDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E83AC19425;
	Tue, 28 Apr 2026 01:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777340074;
	bh=EuOHul4fripHvwsgWhBfbomSmWCRXpHL6QQJMWdANgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3wwXZDm+0cTWZv0apzvd0Puqt7zmIVRJDT3ZJEjl1LYFTmaoffXrM8NTgnQB9KFx
	 1k4UOvVYqfB917urjYIWY7Thvm2rJ1u6aS8cPrZZKrMyVVmASDDA9/w52hhaLjUxuB
	 098Sea66YYRctrAsSmK7BrMwdeXgendh47a0D3kDwzrImPAXnmrrVLZHnpQ77nJQ32
	 ZLbLa1bDcRvBHJvggPFHoI7B/9m2EUPz2uMib7PMqDF99AuU8VHtoG/Ff8w0lD9O6l
	 yePmUJpjWQW80xy7m67Qqb0Ex7I1Vvb8Pj1wCpq7fy8b0+YThX2x5TiGvsngklZ6SK
	 FX1E8bX8A3i4A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/11] selftests/damon/drgn_dump_damon_status: support failed region quota charge ratio
Date: Mon, 27 Apr 2026 18:33:59 -0700
Message-ID: <20260428013402.115171-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260428013402.115171-1-sj@kernel.org>
References: <20260428013402.115171-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend drgn_dump_damon_status.py to dump DAMON internal state for DAMOS
action failed regions quota charge ratio, to be able to show if the
internal state for the feature is working, with future DAMON selftests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/drgn_dump_damon_status.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 5b90eb8e7ef88..972948e6215f1 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -112,6 +112,8 @@ def damos_quota_to_dict(quota):
         ['goals', damos_quota_goals_to_list],
         ['goal_tuner', int],
         ['esz', int],
+        ['fail_charge_num', int],
+        ['fail_charge_denom', int],
         ['weight_sz', int],
         ['weight_nr_accesses', int],
         ['weight_age', int],
-- 
2.47.3

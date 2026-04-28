Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED731F992;
	Tue, 28 Apr 2026 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777350592; cv=none; b=oG1YBGcXMLp0Q4aTbragM4d2EeKIEX1pzw95lpdYFTnaiUohS4MPA/nNzkK3XfexDTR3mv9dNSOwVVfrvJLMqTMm79vdbC4OzsrFhNJ30+jx4gRisxvHmdrCZ3K5t6jStkcEHqPylLTOP/d9BD60zSic5/b7cgKf8rh+VWjM5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777350592; c=relaxed/simple;
	bh=sdIOuHzeJtaYTP8u5YUojhpsDYOu9rOc+EK4UXxTHwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vk8cs4BCvE/A6wed1OVXOsFPoId1Wf3jo3eXGHwij1Yq6YmRy8ng5J7zx7UJymN0e/N7NSipYcQEqBZh9COd/e/LjnCIY8lfepZVkiwEOfeDaMKEcQiFqkO8oW+zjfuRTekbwnZS4G4jgIcIKs+QQPpYm8wm5q6xkIiL423mm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnmVEeVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnmVEeVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE875C2BCAF;
	Tue, 28 Apr 2026 04:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777350592;
	bh=sdIOuHzeJtaYTP8u5YUojhpsDYOu9rOc+EK4UXxTHwc=;
	h=From:To:Cc:Subject:Date:From;
	b=TnmVEeVfdPMWYtEMpVKc4rO5BMoxGjEjOZe3LrCEuY4l4WfQ32Vd3S3bInDxlz2Zn
	 oxWi1aONRu+pSfqpzu+f3HpKbj9exi9PKoCjh37w/vLkFYKhpGQ7paLuojm0M03tcp
	 TzX2cO0QJUkBgtsANS28MED6xeWDnTSPzKZiryzNnMBtMBGXrI/hFl+g6DKrL2Eiyw
	 SE2PQValF7fQ9LwaEaRI4J38kdHGGvkrjc6ilCAX4BFQKL/ombDI5z5ALK2iGMfwTV
	 QPHMVH/2c0HoZepJeNufwnGMG8DgOOSsPMj8MElyvbXpKD0KfCagrEeP+4jyZBF88A
	 WnW1bUp7wNRjg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/damon/core: make charge_addr_from aware of end-address exclusivity
Date: Mon, 27 Apr 2026 21:29:40 -0700
Message-ID: <20260428042942.118230-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON region end address is exclusive one, but charge_addr_from is
assigned assuming the end address is inclusive.  As a result, DAMOS
action to next up to min_region_sz memory can be skipped.  This is quite
negligible user impact.  But, the bug is a bug that can be very simply
fixed.  Fix the wrong assignment to respect the exclusiveness of the
address.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260428032324.115663-1-sj@kernel.org

Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Cc: <stable@vger.kernel.org> # 5.16.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 278594847cf94..37c9a40d0577b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2107,7 +2107,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		if (damos_quota_is_set(quota) &&
 				quota->charged_sz >= quota->esz) {
 			quota->charge_target_from = t;
-			quota->charge_addr_from = r->ar.end + 1;
+			quota->charge_addr_from = r->ar.end;
 		}
 	}
 	if (s->action != DAMOS_STAT)

base-commit: 986c714ac6faa9750e15ccaec72ff2823c96a5c6
-- 
2.47.3

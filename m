Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253B3C1D46;
	Sun,  6 Sep 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717019; cv=none; b=OFhpx5EcWSjpAy+onFD6i5zIqDX39ZsJCi7raMyiRx8yKxioLuamrgITJ5GsGzVN9Q7s37oK0Qx6RTeXyzmi1J7Kx8isH2e+dWrayPO+iOVQ0vSR8rCJl4hxf+shBIFe8uVZiCqKyfws7UCEYXwY0OccToOrYzF4WCUcOnZcYIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717019; c=relaxed/simple;
	bh=s5/ZjWeqUxkLvMahDdQzCr2GDti9ongUwTaeAAyqY0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyqZgAu7pzZItdKHIh/0s0hVr53TpgPrpMCiG+UAa/c3TCVeSuPfy84ifHobCBXtPNzGtlerKuTngXKt7v/KaqzscBSDimQ6l2djF6ue3Ub5+jquNBVEssN4mMQn9THj2r0eJqnXRd1nC05Gl/Ln23iPW47EuGhibAGAd8i30kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ96qSEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ96qSEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ACE1F00A3E;
	Sun,  6 Sep 2026 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717017;
	bh=qNGt4/PEZwlVc60TDCfZwWiqfyGc6ca9ha5f0oSv3gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJ96qSEovdFr+rPvWVoLD3gOw7boUWDPcXDJp5N7f3YjYMX/3x9mFUwmQezC+5Hn8
	 MyHTwXfD0skNUuTjRVFe6ReeFHjwBpfOVEfNCbOoffrBd+3PZ7dApYOJ820q0ys7zy
	 EW1j+1r5LjEritcxlX3R5q1K8C4sHMReAo0eoitQtYX/qrwcMXrNwOIQg0kBot1JHV
	 irE8rBU6q/ESlVzLgWOdLDiaq9yLOjF4ajGxcKOCeef4o+L1/VlvX7w84PS727m1lk
	 /zSilNhJ5C7oYUlK8xmjauFGzmDw2UGcNgtxh12SE23KbLpnw3pZRamTUe02qyjPV3
	 ZqqLQVWTRpxGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/5] mm/damon/paddr: support DAMON_FILTER_TYPE_PGIDLE_SET
Date: Sun,  6 Sep 2026 10:50:04 -0700
Message-ID: <20260906175009.93471-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906175009.93471-1-sj@kernel.org>
References: <20260906175009.93471-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement DAMON_FILTER_TYPE_PGIDLE_SET support on the physical address
space DAMON operation set (paddr).

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index d7c81829445ba..79195026b903a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -151,6 +151,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 		else
 			matched = damon_folio_young(folio);
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_SET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_folio_young(folio) == false;
+		break;
 	default:
 		return damon_ops_filter_match(filter, folio);
 	}
-- 
2.47.3

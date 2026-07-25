Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C101246768;
	Sat, 25 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785013356; cv=none; b=i8vHQ93Chk+3+PP9l+V+TJol6IrHHczojuesVS5AltVg1P6ldbvvt6lba0eeYmYZsihf0RBmvKLdxQTTinHNrjIe9PDLQCQzWaQgt7qC0eTDmTyC+8tvyniEpv8VTBMqKY96bEKcmS+ypl6R/r4cb9n7r065HVa7XOT61BWHUts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785013356; c=relaxed/simple;
	bh=b5kSQGCS/ZAyZmfPJm1xVu80EMtlm0HqrWMr37t/cqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwA9XeiFvqMe4ABLMv1YXsVeCHQpJkCUfc/yXanIScA/Q20Cn78pt3I0n2EM871Bys3jjfUduV4q+0Q+/4igC7PSCamSbr5gJfZ1I1UBr7uKEL+DJ/55DKMRuredGlb56dLi2aUtBGckKYUQ3OXhO7dYSo3CfREPX1hYYxdvIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0SkmNCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0SkmNCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C341F00ACF;
	Sat, 25 Jul 2026 21:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785013354;
	bh=GZDCgXboPWDjpqLBgpT6yf0F7vtlbLEb3w3NI8ROd0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0SkmNCcRAszddBVfeaHVKD67PkiqdMZ3a6juJ0HvdMVBb+c8TpvCPILa4l3G8I2x
	 xS+awYaBkiZtMpjmrPR/8TQl3ysqxjn8MsG/Py1Invs8ZwHhwuOFlXsxsEHme1Jknt
	 Q67b1KaQlKN3Oi3+TGQ+YzvK19DFe+a+dds+71zSQjLdg/WeTXLd530CuaaChSQAnG
	 REer/H+zAoYSw4qvrZU9cYDLvVp9PIos/skkMR/9SK5b6wN7Go8ADVeEuDI30Hlf07
	 oeOml/l39fh7IJA/fkkaRHU+rIoVNVYHu1TpekEm2YBiPMKEjsp2Bxt8oFrX4z5g9j
	 1tG/ItmnaPGNw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Sat, 25 Jul 2026 14:02:05 -0700
Message-ID: <20260725210225.129944-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260725210225.129944-1-sj@kernel.org>
References: <20260725210225.129944-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new DAMON filter type, pgidle_unset.  It will match pages
that have their PG_Idle flag unset, or the page table accessed bit set.
In other words, it says if the page is accessed.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8ad6ef2e063de..cee4b74761081 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -744,12 +744,14 @@ struct damon_intervals_goal {
 /**
  * enum damon_filter_type - Type of &struct damon_filter
  *
- * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
- * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
+ * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
+ * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
+	DAMON_FILTER_TYPE_PGIDLE_UNSET,
 };
 
 /**
-- 
2.47.3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAFF34B437;
	Fri, 15 May 2026 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778805885; cv=none; b=ABDP5/NJ+4rEx2Gz9NHdhsqQ+sDWFeZ0DCHXYRIyJ8ltnf/Q7No9XG6Yf+4UHLSkWYf6psL+x0lgGW+osZzxuW/ljtLLqshe2I/ph/BrOyVWkNLYU9wlsDItgV3977SQndK8qQlqDL/5M0J+SVoZaE6FmQllXWsD+7VCt16aINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778805885; c=relaxed/simple;
	bh=8LT/D7TOnQRawE1lXMWBuu0a3XIQelloreA4qB43lWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPoFJTc50tKoSc4Gp0TdZ2xJD3O8omEChpkSlTBoh2eEo+SAsQ1nP61MrJ+D2An0W3losfuZd29PAraFnjFBzEA1TTVfSokJzy5YhPoJPNIkB7ypfNnWFq3aORPTMXIM8K7Rer+AcNuHprLgjrtGflUX1jsVKilcttQaODbPt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F++H+KOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F++H+KOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A52C2BCF6;
	Fri, 15 May 2026 00:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778805884;
	bh=8LT/D7TOnQRawE1lXMWBuu0a3XIQelloreA4qB43lWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F++H+KOlO8MkMRFskBBG0uJWm7L5IQ1LPJ09nhxBk6XE0A7rwOF/Z3+ayz0m0/Lxn
	 jajmFr4tcELhu1v+vGb9IXiX3JPeBbBxG49JXmsOAT4BnSQacCKpoFNU3Ef9x/V77n
	 OZd7nu1mgTrfG7hPtD6cEvHqM0k/cp7j8+EEgi8XdaakFOrlHBNV0wKM+pwD4V8HFE
	 0SQquwLoAsL5cZnPW101qK5/1Pjzr081BUFQXysh//fXYxWdk393r3Qtajz84zesWM
	 5RKGjwTzHIuTAG1okjniO1BM5lNLjTVvOUlCMOCvbNoOf3w251Ip5hp7hJenv742Nc
	 aREvz/5OIvPHQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 01/28] mm/damon/core: introduce struct damon_probe
Date: Thu, 14 May 2026 17:44:02 -0700
Message-ID: <20260515004433.128933-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515004433.128933-1-sj@kernel.org>
References: <20260515004433.128933-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a data structure for data attribute probe.  It is just a
linked list header at this step.  It will be extended in a way that it
can determine if a given memory has a specific data attribute.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f2cdb7c3f5e6c..a8fff5325b010 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -721,6 +721,15 @@ struct damon_intervals_goal {
 	unsigned long max_sample_us;
 };
 
+/**
+ * struct damon_probe - Data region attribute probe.
+ *
+ * @list:	Siblings list.
+ */
+struct damon_probe {
+	struct list_head list;
+};
+
 /**
  * struct damon_attrs - Monitoring attributes for accuracy/overhead control.
  *
-- 
2.47.3

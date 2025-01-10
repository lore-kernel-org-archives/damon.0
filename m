Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BEF222587;
	Fri, 10 Jan 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535166; cv=none; b=E6XRvf8fTRekXRDrZJHzOVby3ooN1t44cnGxRw8sZ4L69xcOBxhiXefAI7w7HHKQehXvF/uWBLh4mzh4mVMP/qrSEgEuRFmN2oV5jg0VXFPCYRelv91Mca2eHs5HwumQk9NCj4DHAz9WqbD3sf0ftv1gCQB+X4VrgZNBanxnMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535166; c=relaxed/simple;
	bh=cNUCy0TlSD/d2Pmdsrm3XmKc2hpQgSkhrpqQ3/ahDso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDxhbC5552zpeOezx2RQOkw4muSfg8NdpnWM6PMEO22HCFpmCNA0dqC+7wtEFJigkniJiJKnhEbE1F9ozEGSzPZOK+NiSu0Dg1zECn/Clg1LwYtIkYwqUzd0d0vmFRU01V9yZY+d8Tk+P9L6MhChM3vMO/YXW9WxUeUaS9jranQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOJStIW3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOJStIW3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E14BC4CED6;
	Fri, 10 Jan 2025 18:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736535165;
	bh=cNUCy0TlSD/d2Pmdsrm3XmKc2hpQgSkhrpqQ3/ahDso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOJStIW36CNd5fyaROhH7XAA105UoPMXTv3X5+3gEdRxdL8roGa7Udmi7qjQ091Vh
	 10qDvazBoYzxsVrclJ/LLeGyN5fLO6pW/zOd3W9bZ8BXBLdw5qitUDZIKi9w0ydLZS
	 5u8jraLrBtSVYRe87G2EB0o28LyTX7sqb3hUNfVBJDYUFiAORjeQKEu0OG0wwXHmyv
	 0A7iUOtXZZMhDLQym8FXdIRcj2XKwQi+ZvfDC84+gvcn/spWfckXIj8DU5JTvHTyqg
	 kE78jbwpINmyDpsOIudJNDFxrpQHyaZaVnZkNwQkpiLPjjXEIR8CKQ2f8ksWky8oI8
	 QAkSwCkBs4ooA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH 5/5] mm/damon: explain "effective quota" on kernel-doc comment
Date: Fri, 10 Jan 2025 10:52:32 -0800
Message-Id: <20250110185232.54907-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110185232.54907-1-sj@kernel.org>
References: <20250110185232.54907-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment for 'struct damos_quota' describes how "effective
quota" is calculated, but does not explain what it is.  Actually there
was an input[1] about it.  Add the explanation on the comment.

Also, fix a trivial typo on the comment block: s/empt/empty/

[1] https://github.com/damonitor/damo/issues/17#issuecomment-2497525043

Cc: Yunjeong Mun <yunjeong.mun@sk.com>
Cc: Honggyu Kim <honggyu.kim@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0834d7ffcb84..af525252b853 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -193,11 +193,16 @@ struct damos_quota_goal {
  * size quota is set, DAMON tries to apply the action only up to &sz bytes
  * within &reset_interval.
  *
- * Internally, the time quota is transformed to a size quota using estimated
- * throughput of the scheme's action.  DAMON then compares it against &sz and
- * uses smaller one as the effective quota.
+ * To convince the different types of quotas and goals, DAMON internally
+ * converts those into one single size quota called "effective quota".  DAMON
+ * internally uses it as the only one real quota.  The conversion is made as
+ * follows.
  *
- * If @goals is not empt, DAMON calculates yet another size quota based on the
+ * The time quota is transformed to a size quota using estimated throughput of
+ * the scheme's action.  DAMON then compares it against &sz and uses smaller
+ * one as the effective quota.
+ *
+ * If @goals is not empty, DAMON calculates yet another size quota based on the
  * goals using its internal feedback loop algorithm, for every @reset_interval.
  * Then, if the new size quota is smaller than the effective quota, it uses the
  * new size quota as the effective quota.
-- 
2.39.5

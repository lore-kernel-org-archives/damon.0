Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0633CEA9;
	Sat, 16 May 2026 18:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956645; cv=none; b=jtbg1rlpgGwI9843GHdJFrisJ5N1MeQeXYsVpMwyhjc4esUZgip/IBSrjZDlP9J1MU+Kok5Lf8RKSE7ietv8UgyTKJeUtju+TojbJbQvE/7N8sm7u52MGhB2CbL/ub8bo3XhtZ+zYITWonl14JMxmumQgmPpgRgT/xOpr0XYFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956645; c=relaxed/simple;
	bh=8LT/D7TOnQRawE1lXMWBuu0a3XIQelloreA4qB43lWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcqbKEImLXTSkKMES5pgD323anDtYwMkvErQYQv+43H370Ew+Y7UGP6CJ22pcnbSNMdP3yiLQV8K27XXMh2GC7ZVyWFy4FNbkV2c4TArEESe1gJscTT2w5FjxeeWt+woGpcesn3FOA3+vVwSDgJTpkk8IHPcddn3SoqGw9yo2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0G+VqSx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0G+VqSx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE2C2BCC7;
	Sat, 16 May 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778956644;
	bh=8LT/D7TOnQRawE1lXMWBuu0a3XIQelloreA4qB43lWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0G+VqSxQqhSNOCbM6wsCBGh67QTMlXR3OfSDjxrOghE6HDSvj2vv202wLhLeSPeN
	 KROOkX9U1IrIzXNSiHPgtoW+TqB8mfvmn8eRDBeNIEPC68ZPPg6mqx5SBtuuN4DC0a
	 r8lSkbV9G0zk9XBIuo4k2tQ0UeEstaXv+JP91An35qYeqs4b46geQzdKuyZRNAg1Fd
	 h6diPSKky4SwabKoMGvaZk1Bz5c3dkji2+e86kQm8MaLWFRTwS8bB5/Zb4nhi/S4C3
	 dngs81oA6Yk3r0SR8WhZoPSNKsIMe91NXhqykxlY2DybUxMquevnAZhlQ7p9T64AX4
	 BkUk8bO1TjBBw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 01/28] mm/damon/core: introduce struct damon_probe
Date: Sat, 16 May 2026 11:36:42 -0700
Message-ID: <20260516183712.81393-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516183712.81393-1-sj@kernel.org>
References: <20260516183712.81393-1-sj@kernel.org>
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

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968559;
	b=CAx6/DsV3/DZ1waeR+OR4AL/vBFFsz7rRRGPn7Z8GfyyqEVk6+1Inb1NOEw5bPjFzBnj
	 F6ZJDudPCW3SasTBuIuxNHqGVzqWzdzHwLbWGWHKnWbRYEJ6lhGinucee6pCg5UOJUm4f
	 ChPMhczNB+diG1ZVb8hiI9YdfPOfvwvMSyRVN6etXal8Uanzn7o0C1FU9tLTtwtxX3LKi
	 9OVtJ+/78N/CSOH6uBuho/rR+LlgQHMkjMty8p9QYMCX9cBW227bQhNO/PVhVei3R5Fzd
	 SUenECENcVQBVaQ+CEakCFZY3/3QYb5pldMs+54VjLto+MfuKfJTTyyQiGN6dHg/+OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V09JiwnLcA05u7t6X0137O/5Kf7LeJuHza0xA4+7tn0=;
	b=QNCkEGh/K0iyAHVMvkqxkK3aCxTXsPoLk7O4/NyRCJKHs1WnPHzFXhbYnKzZKRsbr+eJ
	 AOCJhjlf0DtEOsqDTV85/0dnp5uRd4fKiy8Mjw+Yo0nSaMASsNm+pg0YLm7Y50P9Ng3o3
	 QFfrlNx9Dwsgv1VF+U/jr8men2E4DaWBLJohu0dr0kNY40TASZHGbEZP2evu+Fq5nz/KQ
	 /hwSPqqHrL/RiknGwNBySK6Hj0D150lWkUxOKbUDZWYHL2X+UnxbhFxe7dUOtXJhLmrHR
	 +puQZ7QXunReHDHh/E7n4MgW8/DqotQPjla42Ig4u0kdAC4A94WmUQyS829S2CrceDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EB6b8GsU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B02606A32C;
	Wed, 18 Nov 2026 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EB6b8GsU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA6F1F0181D;
	Wed, 18 Nov 2026 02:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968559;
	bh=V09JiwnLcA05u7t6X0137O/5Kf7LeJuHza0xA4+7tn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EB6b8GsUXK5cZZ94s4pofJMidxzAQUeutkw/2nrKOve46B5dvbhSAlznFBMLRtLKo
	 AEI7XC/uZijdkVidgEUAJIJY2aOgadBLPL8/t7QEcvsMTZda9J/tzKaOJRHpIXN6XE
	 5V/FEP0qDdu6xWkdlo2Gq3OD5tsvqWnF49Ry9/bSbh1jkEL8UVCK2ViciLr8eQKpO1
	 nX0sQXPiwfh7S2WyDEbl1m1n9rEovRcdA6JBOPN/vlhogPwrHVnSC9Gh7NBWERrXIA
	 kRQNFbgRC0306KzZwjuAm9dnZHsl5uK0YUG9zHGLx7tBcoqpD5vsNGI7q1AllPudaI
	 N7pAEF+SxbiCg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 20/27] mm/damon/api: introduce user_report report type
Date: Tue, 17 Nov 2026 18:22:15 -0800
Message-ID: <20261118022225.100659-21-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261118022225.100659-1-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users could know some data attribute information and willing to provide
that to DAMON.  Introduce a new damon_report_type,
DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index fc84cb9cf5bd9..ab7c362ec64e9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -753,9 +753,11 @@ struct damon_intervals_goal {
 
 /**
  * enum damon_report_type - Type of &struct damon_report.
+ *
+ * @DAMON_REPORT_TYPE_USER_REPORT:	User-generated report.
  */
 enum damon_report_type {
-	NR_DAMON_REPORT_TYPES,
+	DAMON_REPORT_TYPE_USER_REPORT,
 };
 
 /**
-- 
2.47.3

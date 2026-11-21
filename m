Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294828;
	b=WTElubfTBX57OMgxrv8NKVUcTclRtLMZc0ciInpg0QxZQu+aO+KW4Vp9tbZxRwYOnU7l
	 WPYQPvS909/W3qGy3sMQZyShxz9qttxYXgpqZezQRmwaI8GmXlCvdt01c7HK6tK98Gds3
	 2BWmDaCOLMxP2Mf6bgvwfrHBJpOF35Y2fQ7XstaoIceX4lgQ2HpvDQv5VnJo7j2LUN7Ug
	 4IJZp/3Cm0+76SOm0lKb/zhRESTnJeAM3Bu1jIearQK+vap0R7tiIHHmMUajL/R1EvHUp
	 O7aTqHCEsj+G25d0OEhAQ0C+bkY0mcN+E4ylvAaq/bBcje81reZJ3tQzVEt3pxWXi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V09JiwnLcA05u7t6X0137O/5Kf7LeJuHza0xA4+7tn0=;
	b=Zrfv3JIwmiUiXPbo1UpZP9EK3f6z+HEh8CFk5Nm9dqZ9OkVC7MBogqB2brrJvgyMZJnS
	 RDlRjFPfa1lxhR75tUodIleqLhP7BWeBQEZyEvQlSGpi9UQVYvAalyEwZFjgqI5sRlRh5
	 qngngcPhkXHKh0rJLZ856dUf7Ir79kZrZ94BTFSbe66rLEy+h2tv5h1LqFikSOh4l7LgX
	 5FDH1L19MzvH8lpdWmtTDySvfRWw0zZnRWy2iX+WNbBs3U302FxMc6NS4VpvjXHxFKpfV
	 T9VrZOnGeGZXf0P5SppiDZmjE4YasuKnCUkLKeLVvfbidChznV63Z2XJcIPW24DQLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvQdNFRf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEE9606A32C
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvQdNFRf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCD21F000CA;
	Sat, 21 Nov 2026 21:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294828;
	bh=V09JiwnLcA05u7t6X0137O/5Kf7LeJuHza0xA4+7tn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvQdNFRfiefDNqOk1+77DdyHwWvuNo7gY94vJUAYvYK6RQ8nIsEO/qpdUSSzVovJE
	 bUeFlw+sQ5zBfKjjm2DnQwP2jNMEYRXCHm19QgnW8eylCyHO8UZiQJjgnY+u8CQsTt
	 3MYGAqgaxV5cM/Eh+pDklbv+2qTdsf+H1OFZk3bcdsJuZ+3+AkVh3LFiQInZJ0nXIu
	 UEOFVKt06qbHeJ5WwNBSI7WvCa9zQyIkULS0Vs1bWLTpACUcdap2cXzyqK5mcE6rYP
	 wJXujwtydLCfzCtQm62PehDh8fhSwLhBwEp/RGqkTQP93N09iwNDjhyciB3i/SS4WA
	 H6Y45buHmdGKQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 20/27] mm/damon/api: introduce user_report report type
Date: Sat, 21 Nov 2026 13:00:04 -0800
Message-ID: <20261121210013.130397-21-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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

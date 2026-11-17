Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794957790;
	b=N1+IrZBKMvMNS7DMnUJYGE21O+9dt/e32pfdPkp70qVb61IrwgV3/l5kl3m7JCLdDXLC
	 ZC17rbsTS+K+U5Fp7lCsDAgHTqdLC8/pbBWrOwFlyihF3qLmB+Dy/3XhpjUoNCume7/fg
	 tULKIyYmHMM23IDxAiC+DXRS5KC1W156pFXFVN6W6ynMOjR37n3ZXaxR/qTFsrAMqA0OB
	 nXfZIoq4TkCQil7AVXDS608X7MQw+0vd1G4asI/lJXwcbW2YR7VkKcR/d7pxcIrIU5c3g
	 WPDNumivTfwjpAD6GHnJYv7Un8bipFBHmSVnUt856+eQIvuwjdOl4BEyJ5WIkfFYJdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957790;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5ymyID5yWGQWOMH6t/cr1gAlkP/MvA7c8+VMex67FU4=;
	b=Vwmzv+AanA7AZiJs12KqXR89fH8g2iQNxsVbyI9aK32SjhgmT5PQMrxmV+N19yxvznmO
	 Vo77lF4At8tH/rUqdWr42JZFvEzavKgcnP1sA2qMRyxP2Czb4PhT5VhQYk9dXS9zyNtcq
	 N5FIkkiBrFF785aGCdBBP7EtGZk5Y1f/MaKSvYGU+yWnrduzqEmMSu7IEhDqwuHLY+TRD
	 agIgBjtvltCbCUW17yyeMC62cnzwA8tI1YlLd2qUD5O1BILre/pW3uDHDIRbeh09RvOLO
	 e7UXWBfu0l6dqCC7/fmTTh6tcJYb0/sdD45NZWxdXjfuq9rK1pUAhWs78XZ0Sb+51iA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8mBhQAO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BE606A88F;
	Tue, 17 Nov 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8mBhQAO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794957790;
	b=ktMvhGFF1UbTzTB8w2d1oiRSoVR0NdUbkXTHOaC9/si7aBgd/VH+fxdl7Euzk0eNjyr7
	 0F9znOQPgG6fckmtlKBtLp3b69hjYxVSiZAjlNLiDF724QFEKxdDHRdmOkPu6yMKaCedY
	 bf+2UuHDMyPbhYMrf9Mz7KqI7FDAn/pJYd/9zLpK6BRe//3i0Wpzy5Wa7mmYHHOTiiBfl
	 wf3VBYcPweRz5Fv1lRN8iaCalfGI1yPIyaVZ5sy0vphpxBhPyOXX3aWiP+H0qchRyUaab
	 y+YVZd7IFZbkvpO3Ffk/N6+fgN8mxbRJ57Sy0/EUdQb/X3In+/FyOdjXm5uhYTuA6aA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957790;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5ymyID5yWGQWOMH6t/cr1gAlkP/MvA7c8+VMex67FU4=;
	b=JqMg32fALaLFm4SEcouIhbkANsVTfCYDs57rfi+BqDU9Mnusw8NOp3AtdK8kxG5hPtKe
	 VnAX25us1nsDbzJ8GlAzldt2YBwF8mcK8UHgmQvxVqAQgZ7YiiXU+vNOkzuf/z1GPLt0K
	 NyYYNZKHXgUb6MRrXY8bflNA6ZK6eOTqWneES3jLyDyl+q50TFIR02WREGchWVrG8wauw
	 0X3D3/i2RSAq/ko5MxNvA6w/1vcz2qyOLf/QOf9jzPGL2gbmv2trAHkPa21iF9joRCL5v
	 KPR6udeb1OMA5NZE7heyqKL1iDGOEpnGfSJnhmhlKtYK13CaCvzyZcC6d1u/SjBC7TQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 94D091F000C9;
	Tue, 17 Nov 2026 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957790;
	bh=5ymyID5yWGQWOMH6t/cr1gAlkP/MvA7c8+VMex67FU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=U8mBhQAOtY5NvZKfcBKK+1zOEAqHTH0mTxmSF1SBVk/KR+RR+BDfuSK4TMVdQ1g3t
	 XIYl8zu6aijLLk1E6eHpxbh4kVlrnyeZe2qa+8w/C3effIquv5E5RpLcbACBVEqZv6
	 scXO+cYOi0aFobKntUsJG6BBGiydW5jbelnmIVh0tDGoLA0sffQTcA36z8b31wXJwI
	 /73n8t9JPQjY4Z6K3dHesFdNjWK1LZ8BrPsXKoAJTQ5ytUfD4sKjxr7vHbpu9mLlH4
	 oXihJ/U04sIQnYOOxC8ugChceaRPYdMyfPOEB40bgRJ1KTaeK+YNHTAaSBiYJbymH5
	 iXwxQZ0dk+HNA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2CE484AB4F;
	Tue, 17 Nov 2026 23:23:08 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Tue, 17 Nov 2026 23:22:20 +0000
Subject: [PATCH v2 6/6] Docs/ABI/damon: update for
 sz_ops_filter_passed_last
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-damon-sz-ops-b4-v2-6-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794957787; l=1281;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=90a1wbT2PC+F+rhsnr9WMD8Unb+N/GP+Z2kT1pcYBmY=;
 b=pkBlnH43gn4zV/kWKM/02araP3z+bcuBHTyxxj9OoZ/EcohJK1F3SlFgD+e7Udmps9/m0JS/c
 7+wiCSdYnsWDurYzDel6oOypuSIIIpH3e+Bxz68U/vqDCr326+dQTM9
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON ABI document for the newly added DAMOS stat file,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4acb2015c2f4..92348178e48a 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -623,6 +623,13 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Reading this file returns the total size of memory that passed
 		DAMON operations layer-handled filters of the scheme in bytes.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/sz_ops_filter_passed_last
+Date:		Nov 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Reading this file returns the size of memory that passed DAMON
+		operations layer-handled filters of the scheme in bytes, in the
+		last apply interval of the scheme.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/stats/qt_exceeds
 Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>

-- 
2.54.0-uber3



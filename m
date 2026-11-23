Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446802;
	b=jRAV6FOgCjUeM4uzPWOU2syH3zUefASQMhP9wqEc537gwakTitTOQhBaPQgIMaT6zp2/
	 2AB3ya8rw2zk11yuCmvtEYFe0ory/SNxNZuDUzeejaVOD93fVN+x+NJ1+eCikwwtV59yc
	 Ssdk5wXpEav/5MTTGC0yNztRzIv/jMMjovbaz0GtrgcgrADqS/LLgv18WcQqNmvfmLrpb
	 x/MtOPEeQ/p/QGT6N/IWvniDNyBlFN/ZJ7i+XXu2IK0ruWcBEnk8h3xWJAd7h6zhTVQN2
	 WC/ffBEsZ8M8fifQY92D6/6FkNkXQw+6hvxuaVSPFjBINztrKUEpsLadTZZtFdWg9sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446802;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Mv1jTJ/CU74ohK3c9rLtY3Z7CGxLG5rZTuHNMWr+L44=;
	b=ndhev2aHu2R6iElZcFZ1fVn5FdnKJzJm0iWvFRkJLICjWIhpLr7nDSJMQSZgMyFJ6GlJ
	 9+l0Hqnr/QR+EMui8bpztdMmGupIicQNDW2yBCU5PYdAhdKeTbSCvTRirVKDNlNQofSzy
	 lHIjYV05l8kiyI2inzpLP6Pua0C7IEWIapY5jrHaAY6UnFC1986JzvVTnklMvp0WDmKlZ
	 fjRbCS2Z+jdmO/EH/xRH/f2NE7z4l9D1stVNnwTDvRSPbmblQ0RchuzjPr+Ul2u+ztOhK
	 YB+oEaHkQXunTaES3o5C1kRIPKZk8mKuAp6unvSt1tXD0+zwaScdKhVmFpMqbLE6/zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0mKHdSO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A928606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0mKHdSO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0FE1F000E1;
	Mon, 23 Nov 2026 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446801;
	bh=Mv1jTJ/CU74ohK3c9rLtY3Z7CGxLG5rZTuHNMWr+L44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O0mKHdSOa+Rf49S8071hoHr2ZSrIchkChN8nzXK84k+SIYLqUoS/jLcLfbK6jdIsE
	 6eFE0Q0c9g/Y9bHFbj3D0HNYKL2eZAlXkTMFyNzaVFhkGYKI2ofgPESdgH+dFB/Y29
	 qG0WqDAwAa7VYy6k462SEGltprQCen4hvNGv7WFfBGLLEiqcbTGXLA4hmYV9qsCDH4
	 bgldDcKQUn3GdQRiFPyN7hNo/qfK0h+lkoXhIi/+oeNiCIkC8yJ6xaJnQpxjjEuRmu
	 7zsVgTjGsu476VR86opZhiQKVPX+8/PX/aGARoS+7XQo5xvyKUFHHw4n1haaXlgdDU
	 DV6fEJ0+FdLwg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mattathias Pinchover <mattathias.pinchover@uber.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH v3 6/6] Docs/ABI/damon: update for sz_ops_filter_passed_last
Date: Mon, 23 Nov 2026 07:13:07 -0800
Message-ID: <20261123151309.82675-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123151309.82675-1-sj@kernel.org>
References: <20261123151309.82675-1-sj@kernel.org>
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

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON ABI document for the newly added DAMOS stat file,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 4acb2015c2f4f..92348178e48a0 100644
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
2.47.3

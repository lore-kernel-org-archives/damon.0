Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667592;
	b=vZNSBm6qYDg4chYyBzRw8ElyKmg8LqgYA98O5EBe/HKhV7OOkdFHFWv0IKcMNOBH2Uww
	 kVsjDLGJAyGTZH2YLzK8uh79r/5MseDsdRHzmsQYRf77JSVoGH0zcZVRqkVU89vpCQBBj
	 Pb4pALX4U44G/PgSW9lTY00LIwubOHv2Fc83r0mGgTvmpUMlSGjTRiC4Kj0j9ocvTb0PC
	 EIhOa9A2CWmFO/WvI2tr/44hZGBbofhOOIjBYD1gx52Sea8+7kezOEYo36xFMBldVr7lc
	 QF7uWEzdLyQmPVUT1GECWTXhOq0i1wkXDjQsUrKxo4QSq4Vv8yQA52DI9QyXiZb/yjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0jLh+kpsC+u5aQYQiS3dDnOCEe0oaZ2yOrv+7RYFpbc=;
	b=BwlzrugOyWPplT5U4ef5gNFSt2wCK4bultNIC6B3qHZgwK/G8DQXFXxWFEADiRFzOePB
	 bFAL7ZtoiGgw8itqLutGuK3ECPZd+Y7KUEC/wgFxeALRwGD0HrWD2eqBi+Th/LupfDUYy
	 p1ooiOHgdvkv2lmQKXLsxiVpxAlB8dHet3xOKar7WIMa1RwbuTYpm9MprfGS7y8x+KaU2
	 kPjkZy14azI1/KIaByK9qtP1O2sDSpptdPsruAFwmQroY/oCb2c0d1U7WKWw5Q9OqlnzG
	 zXGilHZL6GkoOBm076SpOp+d+hALDacVTpUXBgRvZg+IM9adrWMRIVJjhPZiBBvR1rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipTdl5kK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2174F606D81C;
	Tue,  3 Nov 2026 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ipTdl5kK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E161F0093A;
	Tue,  3 Nov 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667592;
	bh=0jLh+kpsC+u5aQYQiS3dDnOCEe0oaZ2yOrv+7RYFpbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ipTdl5kKhCfP7SX3k7MeP8+CdBr96NVy9euQ7+2RvQHPRvRtjpnDQ/GpY3Y+5Ao+I
	 tln0MTWMcVnjkWzzw/1iqHZdSz9b1LE3XK6wsGV1UuRQbladcQRXMXM008z7VYdhey
	 eaHUgBx50G3agLmZ6Iyl9K7xmKaec8ST41TSz0/qMzOoM8cRRk1xHzNGjnHSwKaUWm
	 /JLZ1xh3nhjfPPhBBQVLdpvdCPTHdSP0uUmfKr5AaAIMdmODrX/21sWq2SytfSJ0qe
	 OMzWRC6L/JUpAJI3bRTwBwa2esgacwR5C1FTI6HYhO8scdxKIF5ydFbeT9gi3lMG4r
	 RZAJDXmcFTqmw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aveline Noir <jm5905938@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	SJ Park <sj@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 7/8] Docs/mm/damon/maintainer-profile: fix subject-verb agreement
Date: Mon,  2 Nov 2026 16:59:37 -0800
Message-ID: <20261103005940.91432-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103005940.91432-1-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
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

From: Aveline Noir <jm5905938@gmail.com>

"The DAMON maintainer usually work" should be "works".

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/maintainer-profile.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/maintainer-profile.rst b/Documentation/mm/damon/maintainer-profile.rst
index a7c1352339378..c482690320249 100644
--- a/Documentation/mm/damon/maintainer-profile.rst
+++ b/Documentation/mm/damon/maintainer-profile.rst
@@ -63,7 +63,7 @@ management subsystem maintainer.
 Review cadence
 --------------
 
-The DAMON maintainer usually work in a flexible way, except early morning in PT
+The DAMON maintainer usually works in a flexible way, except early morning in PT
 (Pacific Time).  The response to patches will occasionally be slow.  Do not
 hesitate to send a ping if you have not heard back within a week of sending a
 patch.
-- 
2.47.3

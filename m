Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968561;
	b=Pj7/oF3Ke8fQJon6Tw2IhhFmlOgkORjV2DkV2O+ZJBZMj08oBAWG/1KaDOwbJnB6yvZG
	 oKN6qUY3kGh/GPuuuBQEt5r2XGjQ2cf+YNYjnbGL4u7QzoXzM7MthFTlLPtxAkti1eK8g
	 0jF35tMLMWV8XUtbsTDXx4fTsnvpUokbt6s6Rz1IHvas0F0H0aN0BS2s4LMfbMQkmHkZU
	 0+mc2JTNWfc1DP0awkV9pFgGMLhVUhrvWXI/+s+rXKDStypCoPjrV/izXErgB9yI+F1Xl
	 Mh6hsd+l4/id4B8IWb0BX5f/M2ulZnpLVpr/q8M9Erf7SKR2fHJUSxZr89a8MOG2DsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R78z6DX4Eb7n5m3aMS1vuBN9kYcpNJhnmoRj2a8fkoA=;
	b=TYM6A1Z0/rgd5innMw6kgPNTGi9zei7L/5P2drlW8dZ9H2VMTAsUAM8U6u1MqnrIqKJK
	 j1UHxj60aW74QsnEAVkT7pEwSxBVA7sWV/0FGvWKVynlusCnN8sDUrdhi9AYkQAmTNC+8
	 Hq5HlrOkqgJ0mQA4IDWmpN4Op2ntDl4+OrtQFj3hhe2dfHY+C9hgHA0UJ+TbV5PjBlQXo
	 ZXfKrTfYkUdKE6Z15QzQ8i3xt8Ha7s9s6KMhXjpCCiOEicG7iOeqpWjhLCX8/cp5P1SWD
	 +R/mDoGf0bmelIWPU60D1aniI69mkho+crgWnGVxUs2PJZ1c7VIql3CMYprt5GjS3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0SNnpqB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93801606AF50;
	Wed, 18 Nov 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T0SNnpqB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8311F00937;
	Wed, 18 Nov 2026 02:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968561;
	bh=R78z6DX4Eb7n5m3aMS1vuBN9kYcpNJhnmoRj2a8fkoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0SNnpqB8t6E+4PGKkicOyA2bgdDL/KGqJbfnKjnPtWYCdSM4Ao8uhj+FPBpzYf+N
	 HeQhFnTFHqH//dgs+C5CGx35yY8jEGRhyHyWyrn7k/inqiN29OZLUpGHS4eIjEnSYr
	 +q2Y7PzeRRw3oqfTh2j9sOhWGOgzQQJxSbHUtMEgmJtuiZRUBkhwsVdt3Vo2jbgWFb
	 H58AbiFDMLJVt+Sz8wGVIyPEZz1Ij4Gs58dknyEFqfaeS+RGaBrPgJEpy1z56/Crie
	 Tpo+X3CmsYsTB/WXtE6Cxhy/iB7U3ZKxYYapOcSRBzE1sQkM0oj5BnhNY8EWgc++GZ
	 kpbZ3KziTHuGA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 26/27] Docs/admin-guide/mm/damon/usage: update for user_report report support
Date: Tue, 17 Nov 2026 18:22:21 -0800
Message-ID: <20261118022225.100659-27-sj@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added user_report type data
attribute report support.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ce4e9e4c13276..4024dd4e92979 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -117,7 +117,7 @@ comma (",").
     │ │ ...
     │ reports/
     │ │ producers/nr_producers
-    │ │ │ 0/report_type,producer_state
+    │ │ │ 0/report_type,producer_state,addr_start,addr_end
     │ │ │ ...
 
 .. _sysfs_root:
@@ -767,6 +767,15 @@ Users can write below keywords for the producer to the file.
 
 - ``on``: Enable the producer.
 - ``off``: Disable the producer.
+- ``submit``: Generate and submit a new ``user_report`` type report, if
+  ``report_type`` is ``user_report``, and the producer is enabled.
+
+``addr_start`` and ``addr_end`` files are used only for ``user_report`` report
+type.  Those set the address range of memory to manually report .  Users can
+set the start and end address of the address range by writing the addresses to
+the files.  Note that it is open-end range (``[addr_start,addr_end)``) and
+therefore the end address is exclusive.  Reading the files shows the last
+successfully written input.
 
 .. _tracepoint:
 
-- 
2.47.3

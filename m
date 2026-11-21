Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294830;
	b=YJ1EekwKTmuu3b4JVy2qTOLI5CT/K4lky9fImms8B7jaoLHr+UAo/rNl2J1uYjYqUU0M
	 C+u+6s8DrQZSeByddyqt97eBBU4rdVzcOqFFZy9pOkTQLgNSakek5ywQsizpoT1cNAid1
	 krwpEF3w7R+llUuSJ25PDGacDPGAtacPsYtfDUybQUdes4+S28iM41mHKe46JvnO/Msoc
	 sfTOuc7mQvq9vFVs2feye/h1PH0ui9s7HI6ANAOd30FEM8wAw4B76WZ6Rd7VuV5LorMQD
	 e9gwHAXRGJLTy8SYaAdLx/iLkWpdndp3Bi+6IkixQB2XqnuN2b2x0JbIdW0yNjv4wUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R78z6DX4Eb7n5m3aMS1vuBN9kYcpNJhnmoRj2a8fkoA=;
	b=CQUdh9eG3IoMiUKx6Vg2o2SE2rVZ4nELbjb4pMGUVW8nTo4+cxuGahyvkm7tYVwf2GHE
	 56dZH4g0ORRut8kPoDgxc5f3fQk6clEF7nvU5Lo2zZVEHi70g3KDH67R1n0jPvlouljMK
	 qNnIxm6RA5JTXB40RgDnmJTsJqVXGdS2e/fYbaHN30Wxaeot2kATwphLOHNXlkngpkExf
	 xI9jdPgbQMDQ0FIoLzULrPv7A9yDwOJ1ebXpIhkX1AFCwuDPDVcDyC9o9H8IxC1keJiTh
	 vn4ishd7ZwyZTYt1rb7BP6MbBEeVwL5EwTs9VY+LTFr/AFS/atlUG4gctEvt4nTgFkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqASXeKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A715606A333;
	Sat, 21 Nov 2026 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dqASXeKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E5E1F000C4;
	Sat, 21 Nov 2026 21:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294830;
	bh=R78z6DX4Eb7n5m3aMS1vuBN9kYcpNJhnmoRj2a8fkoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqASXeKu+Dq+WbuRnw1WxH4z7XTnbThZ8SRYZ/5+YPOCxXSLmd4QBijLeiYUGOScj
	 I7ZmK0r+ZABwEUXZOhJOlbKo0MtScJ1oiIHQPP6OGFxSI0gcci0w82jltlJEax8khX
	 dJC7BpPqY1+OGy3RDYH4AlCm59SIsOjMmX+h3/JQRVgtTMVXcYiK92+70HPJMJPL6k
	 VgdffUVZnfSADWyUpw41PxqRnEP5prj2OzNOsEm/HsI3Ps1U4EbZptYEdytHqN64FG
	 2unObWA72qmQsv15qGPgjDb8olmIccGh9mAgOGWRpkVm7h0sl+D//N9g7sR8I4w2o9
	 s1//u6YtN+WcA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 26/27] Docs/admin-guide/mm/damon/usage: update for user_report report support
Date: Sat, 21 Nov 2026 13:00:10 -0800
Message-ID: <20261121210013.130397-27-sj@kernel.org>
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

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294825;
	b=Zfwu6RL63lPlMcx/M+g0A8bJvVGXeKmV6KbVql9q0ErV0uv0/iZcpv6E07YmWLpnzH4p
	 vAbAfPq2UPZzCu6hhe9o6kl7fG87OjYKI8kzuIpM2MBk/OWbmDAUXlOp7EiHQ43Y6tCyD
	 aZa/0xv4Ao2L6KKxSfS+PQOFl/pYTnVT7iWq+9FOr2geSvr8h/vCSSp+K0zN8nskqpXT0
	 5Wbg4OZGA/0J2tOqYU0sfBv6/ZZtgpISQSVmpgOEWep29++nZbpJt2wnBLR9sK8ggh4q+
	 oVwljO0cPAmZ/tO1s0OrOkIUk+R/F3/W3943iD+SgzNlVc6skAnuIQ62d3381jvEcJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+3VuRAkKYe8EHkp2JgLASOtjfe+EnSMbvCKOCwj6jzs=;
	b=w+IlV+8Bwtp9yU7YkG3SDfClPW7gEtx52mDFu1Jed94MRuvyDqTokLEiFUgBV+kOi6Yi
	 U/V5cxnyLVMRqh4i6ZQXs9Ugl8m40cWS9XnzBXeuqrIbRrfxUN/YlrcnYa4P4DPsAwbEU
	 iSr0QnZ6cgrUbCIeN5jD99KYSPKbppIx/vfVXZ22HKLbb6V5F+b2JL+yoDO9l7gr5StYr
	 kBhvcsanIJXcjJT8vSOmSfq0alVkdXisKaXdXkf5H1FOAYDTSYKWU7e/xi2OvLoKEjCA4
	 dbAKHRbBycmf3RFJGo96NJUKlUjQBcCQJf7+c8wkE1MNLEhg46vFAXq1tz5m6sQH6zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgqfAVce;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216E606A320;
	Sat, 21 Nov 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RgqfAVce
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6085B1F000C4;
	Sat, 21 Nov 2026 21:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294824;
	bh=+3VuRAkKYe8EHkp2JgLASOtjfe+EnSMbvCKOCwj6jzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RgqfAVcef9VHKtexYMM4diHOxHUexB986bI5j8yqJk83roysvg7ymlzOefZUI77Jy
	 3PGMcM4V+MQLlUgI0Kt/jqn+8MCnv/Jn3D4ozAEZ55ICdTCEdKxTY3y5b6KexGN+J0
	 2TvYAzHOW7twWhbOCv/dK+zXmX3gFo3h/aeTsj64jinAsK2RL1ByiJzdW8cNP830Rw
	 6kGFY8BAa+WEkbKDbsYa5+zvwYxRjPllcIxYpTkomUKXdjRBWOG5VY0qzjbH8m0dBx
	 RO+BHvL5m/IqfMeE9TXrsT/pUG4k9ugZHLyzZa0W6AoGY2zC3JXIRz09+37uARKA13
	 BQ83nhnuvLTAg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/27] Docs/admin-guide/mm/damon/usage: update for report producer sysfs
Date: Sat, 21 Nov 2026 12:59:54 -0800
Message-ID: <20261121210013.130397-11-sj@kernel.org>
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

Update DAMON usage document for the newly added report producer control
sysfs files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 6093b1c8fbfd9..644250c7bd681 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -115,6 +115,10 @@ comma (",").
     │ │ │ │ │ │ ...
     │ │ │ │ ...
     │ │ ...
+    │ reports/
+    │ │ producers/nr_producers
+    │ │ │ 0/report_type,producer_state
+    │ │ │ ...
 
 .. _sysfs_root:
 
@@ -729,6 +733,37 @@ Please note that it's highly recommended to use user space tools like `damo
 <https://github.com/damonitor/damo>`_ rather than manually reading and writing
 the files as above.  Above is only for an example.
 
+.. _damon_usage_sysfs_reports_producers:
+
+reports/producers/
+------------------
+
+Under the `admin/` directory, ``reports/producers/`` directory exists.  This
+directory is for configuring :ref:`DAMON report producers
+<damon_design_attr_reporting>`.  The file below exists in the directory.
+
+``nr_producers`` file is for generating report producers setup files.  Writing
+an integer ``N`` to the file creates the number of directories named ``0`` to
+``N-1``.  Each number-named directory is for configuring each report producer
+and called "producer directory".
+
+reports/producers/<N>/
+----------------------
+
+Files below exist in each producer directory.
+
+``report_type`` file is for setting the type of the report to produce.  Users
+can set the type by writing the type name to the file.  Reading the file shows
+the last successfully written input.  Refer to the :ref:`design document
+<damon_design_attr_reporting>` for the list of supported report types.
+
+``producer_state`` file is for reading and updating the state.  Reading it
+shows ``on`` or ``off`` if the producer is enabled or disabled, respectively.
+Users can write below keywords for the producer to the file.
+
+- ``on``: Enable the producer.
+- ``off``: Disable the producer.
+
 .. _tracepoint:
 
 Tracepoints for Monitoring Results
-- 
2.47.3

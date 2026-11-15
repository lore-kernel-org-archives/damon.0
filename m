Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774546;
	b=GWf8iIbJRvz0MGifsdfScLvt3/Jc1mQhyU+AQnGk1xxbBPIgFSaMPS1GSYqkV4XI3JCj
	 5MdLjGYyKsp1tSNUd6RFvqSn2zJdzQToIADFEm5nQTZIwE+AzU+K6KueS90DCBUm1DNEG
	 XGpCCe9eCCjmI4S3FELjiSeWySQUu8udipSfhvcM/E5rXsXkxrDNJkUVD9b+mFuhhSGfD
	 lFqLb8HgVDqT2XWYZxn1LokQj+Ka3ZEXGUjSKvQ6/ZwDygIH8QcKH1a10Lo2feO11Zh04
	 ++BUon09OIHrOnMx2Qhj98LdE2wmnoufp3EpgdJDFDxJ2A9thCkD30/nosF3ONhbtvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774546;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+3VuRAkKYe8EHkp2JgLASOtjfe+EnSMbvCKOCwj6jzs=;
	b=T3JrebiCXcruwrv36LECsKXRiXEEaJg5l+dKpJvIgskmb2gP+TAAdvA0wSGCMNWowcVv
	 zGCuJoiu8C34NulQdWJGle8qLL21o7avTz6vPGiPdsK3OjSCFQMp3mytWrX08oVtN2g7O
	 iBRUdjagJqjoUg+KlOqgB8W81aqRdV1AByRFMC+/W5UPq5jNkppv6FB88I26Y19MhitYY
	 rCOHW3Ay23MA/T2YCvrp4pE6q4vClmrhK6kZUwvSselinWf3/ey6DlNju6CkUDCOwUXD5
	 Iq/PGWb8SSJj6UI278mV3Kh3Hh4nick6EJrvZrQHN+u3NC4j39wN2SlNQoZV0VBVrrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+G49136;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD860A263C;
	Sun, 15 Nov 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+G49136
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E401F000CC;
	Sun, 15 Nov 2026 20:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774545;
	bh=+3VuRAkKYe8EHkp2JgLASOtjfe+EnSMbvCKOCwj6jzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+G49136wwxaZ7daOM8i0MeEDwl7M6F8kfu4MtvhaBwW2lBnmR429BM3aSPFCp/+F
	 v/3BkyKllUAelxzCZO9uOMxmPEGyh7pCru+tcJOFHZk8az63JFQMhPuSlo9f44JI02
	 VJrIn6yxwzdffNiYQI72C66ZSneNYFdU1AFv9xYylKyaDSg38x0LCYrrjySS8x/b+N
	 MRyyECxGJyObWYhnQTm500G3u6AShzMRdZBTBIydLC7/Dex4gNTMYiQB7frNDiO5rf
	 TrB8NawOXjnRiQPbSw+vb0hQQO0xsCF8aIn8cdCjq1Ll57RovCIED31PUPbHDfbWZJ
	 vGqUJTZy9N/9Q==
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
Subject: [RFC PATCH 10/27] Docs/admin-guide/mm/damon/usage: update for report producer sysfs
Date: Sun, 15 Nov 2026 12:28:28 -0800
Message-ID: <20261115202849.99134-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
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

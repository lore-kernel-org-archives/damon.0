Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968556;
	b=c0va1OwLURdDw1GdkPylUr14dHCDUj7S2L6jfPvvJfLB/P0iOfDbDFSgva36Mvgmxqxv
	 oYiARzJ7DO0FjVGB3jIk5fDB1pRVis1sY/qk0tsorgHVnqiBKLWG+f1OUvmtMQBktNGgR
	 b/jFKNEldcQr+rkbtWvBumgnZ6uGvkgfgGzlYmIw+icczMNPHRA+D/ncp6oN5RXdceX9E
	 YN8ahmpR2kAObjSymsHP7EMxkHZI1NmrijmVXBf1X3T7U1LkeKFrVZtz9IRFHNKBus+Wh
	 Ct/qMkuaWufo1DDIrdQr606QSf8JPUmznOqxIEv1hoFGRn3X9dPwHjIbcd2tkRIrVMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+3VuRAkKYe8EHkp2JgLASOtjfe+EnSMbvCKOCwj6jzs=;
	b=Lqdpe1ttBe2RXOJK7M7w9oNC32aCqJF4jGJAfJ5eI4OwfaanlPITYDnwin7Z44uWvS/8
	 4ArY39rsP9qIHI0O9dxFuH71i4mFda3farJ1cQhAPXK5Pc+FQINPcmw62IMab598Dl0Oa
	 zwvvI1ZZmWlMWeFXB3FDhuZBz3EPeNv15vmTXau259xXFB8/G7w3r9yzgwFvJvsq+vH/0
	 GliDoVAhp6b4gvx0ukdLyahAOaEV6ZQqF2wvDVB+IL8lP1iiurva6U4lV98fGttaxYyH2
	 etY4Yt43eioRP1S+HF7ah2ps6xVzjEal43IFOZ4GtR5tLjlf9V+W4mx87LWsLVSDeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5OIPJD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F629606A325;
	Wed, 18 Nov 2026 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5OIPJD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89DE1F000D2;
	Wed, 18 Nov 2026 02:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968556;
	bh=+3VuRAkKYe8EHkp2JgLASOtjfe+EnSMbvCKOCwj6jzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E5OIPJD4OmpaRADMH53N0EpGSCnMzOef1jIUENVaS/YVrGBfeNJJb7qMVVUDBEgQc
	 RY4rODElY7V7kq05Q4LJiTfSNkSmOqW/M6OWaTHcjLjz49fqhQFO0lN/8Te5QiL+8O
	 4jnN1vaEQugd4Vz+ePmYCsHkSUqeA6wpenbY5veMX+6Y7dflibA4eX5udJPxrlK2A7
	 0F8wE4A8T9/0erD8TsBrAFf1hz93h8Nuw6QHGiS+Cn8qb92PM+lq52jvrbjEoiX6Ms
	 xEWYiXJMcK8LS4amnLuGy4Fg8mCX237dpgG0ZeHIhzSlWzYCpKWYQpjDz93LIW2/5h
	 1awEoAVTIDJXA==
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
Subject: [RFC PATCH v2 10/27] Docs/admin-guide/mm/damon/usage: update for report producer sysfs
Date: Tue, 17 Nov 2026 18:22:05 -0800
Message-ID: <20261118022225.100659-11-sj@kernel.org>
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

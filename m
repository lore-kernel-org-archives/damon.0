Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534612;
	b=qCFIpodEZWep0LyU3VBUZxrc+XEu/tjLoKT5vl/uKlNsOEL1mwhm6Lt3GUYyfimnmH8v
	 6rC/DHHzTx4szaj0u6CJtFUWH3C869RcxCI149X0AOEjknhkgNCwWgtRtfeEbv+KvD59z
	 SMrZpJg0Kt+k+Rd5M8clIJ7IVbXJOC0bZZRu0dYBpJ20Dn8Gj8B9uNlx2z2PIePnJyyIC
	 TUVkKf+Vw8mKsdSurvu1X1YKmDKyqd0jAfgv+SK6Hl6yclGx8wq60/baN7YYQqm1vIdfR
	 ID/MhBmLxnF0roO3uThLGdnSfXlDa2mGT9LlM6eVVo4exu4UhkTXHheBsArd6Ok4lmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=N+3Kv3h58VrY/LyVwtKRPMKl+l1ZZJYm9dKAaxGeEwI=;
	b=h5hLgx1kR+LJKIK49iC8xHQk8ZDIV+f8EcGNcpi/FgHnQFKYoiLsdxiWUi+Z/AXoLQ6l
	 pjddc+drvpPFB13rugrQFdWBtwyRy1kyWmlsOSw7uPxIQ4nQ68tsdTiVfhsRb/WpRXKEy
	 Mh8EPPW+P7YJod/yyOidEuL5IHcJiMuZQE7o52ZfFqkUTZdRNyJF0ngC7e2q/1qg4fHvO
	 ys3UQPm53gochxtoJLBcRx5dwQzx8U99KlziHPaWSA0Gp3ZhHGebtOHvEVUV/xOUx2bWP
	 4F6PGgslBuGs+p3VWWiHKYffPoItldD/dKtfJyPW5zv9DmWyDdeCRBfnI+Y7JAYKvkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koT4gIdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543C606A329;
	Tue, 24 Nov 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koT4gIdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6091F0093C;
	Tue, 24 Nov 2026 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534611;
	bh=N+3Kv3h58VrY/LyVwtKRPMKl+l1ZZJYm9dKAaxGeEwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koT4gIdxpF4Gd7m8AN/75DamYXS8Pc2Hxr05MnBc95/67YqzKYJlIkmXNC+CW/Qhb
	 KjBC5U1OLx8wOlh0BCwApBYiPOXOxu875taprrq3CssrNy4yrW0pJD4vbDk3eUU73J
	 kl3E4Ezk7FE5Hsd993P9m3/m5kkDS5b4eNu1YErktuKIAyW4EVUTq90BYjFo6GWtgC
	 7a8UKJ9796a/V6TH20cTgAVCZacwpP4zskFsLIuQ+ZkW9J+dGdYEKTOvWbf+AOjHHt
	 yWYpk60Uge0mkE1XGTmuT9M2UQQOJb/JX24i5E4NUFUl+QyfnzGwDw5AAQb0rXSxPM
	 i9B+eqsFZMOZA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	Aveline Noir <jm5905938@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>
Subject: [PATCH v2 10/27] Docs/admin-guide/mm/damon/usage: update for report producer sysfs
Date: Tue, 24 Nov 2026 07:36:16 -0800
Message-ID: <20261124153636.91854-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261124153636.91854-1-sj@kernel.org>
References: <20261124153636.91854-1-sj@kernel.org>
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

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 35 ++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 51c4909f1a8b2..5e0633b5879de 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -118,6 +118,10 @@ comma (",").
     │ │ │ │ │ │ ...
     │ │ │ │ ...
     │ │ ...
+    │ reports/
+    │ │ producers/nr_producers
+    │ │ │ 0/report_type,producer_state
+    │ │ │ ...
 
 .. _sysfs_root:
 
@@ -732,6 +736,37 @@ Please note that it's highly recommended to use user space tools like `damo
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

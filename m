Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA73C2586DA;
	Wed, 19 Feb 2025 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740002515; cv=none; b=SgDvhmzFYzwZQTb4QQf5Y85Mdr8ZYNfBQDA5uMD9UUAwtr/YP5uPeeuAuFOcMc7hCkTGUlfUXkA4RI2OAVrpSLQSfCEsxadlDFiO1S3K9DgDRjVsIbGrch/L51glgGTSfuFdpqU0RqcJ0yBO6PEgEYBOMBDhFEPpnM++UD/snBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740002515; c=relaxed/simple;
	bh=65ixF1T6FCD2z24Z20ptB4DR16r1B3wdTRVDMcZeP7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUAtyqOs+TEDOHmlEzVbXE1a1uxedhE7wyXfOrakdDkRdsXDCeirrP1SVWZKSTOVzxq3qJ/Dxe/LVp3iRq8lUkwf8be/kMZttrwVWDPrpP+RgkkSif+wnCbuvaxkZ/T/A6+yXizZegOz5JLnFbzgYXVb4WQMNmDzQcnwlJ5EmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGqnPWha; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGqnPWha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08384C4CED1;
	Wed, 19 Feb 2025 22:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740002515;
	bh=65ixF1T6FCD2z24Z20ptB4DR16r1B3wdTRVDMcZeP7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGqnPWhaaQwoXEtKV799Wpny3FCrnYCyWciM2mss84kRk0C+JDOrYpxBVI9SIngbc
	 E87KhrpCio/ZSwNakrH71PhnePTNc4X9cty1z3AnjkM7sZ8m3OV+PpBT0Bp7HwnDvI
	 CUjfcgD7rZaJUXt3FabWgwRFqxeog0yATg3S9TPJNaSPE7JthBgzNtC1wd7wsi5834
	 axTt52dH/Jo5XCWPato7Ptil4NY6WsLx9Decv58aYTzFxgxTdRtGz8lfYgibF0GWBu
	 anQIENQRaZP+bpQSU1QVFN2NRt9Z8aW6qWieilwaTqkzwM8XF+wb9G0EzMhAwseZRs
	 vZDTlT4/42YLQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] Docs/mm/damon/design: document unmapped DAMOS filter type
Date: Wed, 19 Feb 2025 14:01:46 -0800
Message-Id: <20250219220146.133650-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250219220146.133650-1-sj@kernel.org>
References: <20250219220146.133650-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document availability and meaning of unmapped DAMOS filter type on
design document.  Since introduction of the type requires no additional
user ABI, usage and ABI document need no update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 6a66aa0833fd..5af991551a86 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -617,6 +617,8 @@ Below ``type`` of filters are currently supported.
           scheme.
     - hugepage_size
         - Applied to pages that managed in a given size range.
+    - unmapped
+        - Applied to pages that unmapped.
 
 To know how user-space can set the filters via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
-- 
2.39.5

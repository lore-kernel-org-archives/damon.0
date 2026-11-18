Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968561;
	b=X3QQpDeiGLcRig0v4FNWnqYpiKihP1eav3TCGPSWnFGwSA5Ka6oh1gLZqI2lj5nrgiEE
	 Lvu7C9zwZCBQWb4J27H9niR1+Y9ug7L5k0JfrXuFXhmT2gLQszN/ltOEU9Ljv5a49F4CE
	 H46m8i7GUP2CCAW5G/jQc/TimUBNKSpT9YwKOhoaysZrmNg8w4x0NWfVwqJuH5GQZcva8
	 itARFYs4t7gZDzg5DChz4ppfNtlu3v2O+mrygLJ/Kwuy9ng5eQQJgfdihwRjdKSlSBmxR
	 OHK130brxXHj7qmSLuhbTh8cOcqkLVADNcUQfwTFZyb0ilk1HsGapK9iWc/ViHGnUww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NvjOO/+bldLi0/nuMY9P6FGGyFYE4cHne1cw3VHENC8=;
	b=MhcCRGmIefkX5Gs+thKinzQeqZvgdnL6u8ZAyOsrnfGuQYc0asqWNMT5DLAuJGJU/UWM
	 hHu4bc//rrahQFWMb84+GBOdpEe5bQX3ESbaWwS7GprsISM8OIJhtSq5ZkA5jj/b7dJRt
	 qcbEt36Z9w/vdi3LhAYQq11vnpbJyn+PLnmCAO7oDBbgGmfAjasr0T2Os+04Pd4chpMsp
	 054wrG66aeWyIlhv40+D5CEY60cJmriK5bB2T57DizG9FdsPSyTLAo+9a/aNR+hTXlRqe
	 6sQUX6WC1MKHYWKPTTlBaDCnq7PBCT9uCqTxeIfNiQ4E1mvvSl7ICW+Z/QHkNHD5osA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfz7cacu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35504606A8B4;
	Wed, 18 Nov 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zfz7cacu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA0D1F000D4;
	Wed, 18 Nov 2026 02:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968561;
	bh=NvjOO/+bldLi0/nuMY9P6FGGyFYE4cHne1cw3VHENC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zfz7cacux/v5GdYH1AuV6xtxi/eRrHARePwugEIDfZSDLDpj/enac1aQqaJafBda5
	 I815yBy+XZYzF7Bm0GPqdjg6UCLqTztBosnhIkesIXcZlOxJ5giq4MbuPyuSxMAo0C
	 Kjcxq09uScbcYQ+E40JMTGMO4Q6WJCU9/rzonAWKI2AZD22/Kx+8X/j6mpnp+Tw74f
	 tQpUTArGQ6UxJIBBM6kJyH6Ir8Oq5UxOfnmmrWq2mbK8PBkSgho+tlzGMUPM4x3Cu6
	 mazWRooGZ6V/e4GtCAlCQzyXD2CB7nvVkZk0xTkGT0mdKGHSv67YckNi880FIe4hIp
	 WYcR6IRmVLeWQ==
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
Subject: [RFC PATCH v2 25/27] Docs/mm/damon/design: update for user report support
Date: Tue, 17 Nov 2026 18:22:20 -0800
Message-ID: <20261118022225.100659-26-sj@kernel.org>
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
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly aded user_report type data
attribute reports.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 31ca623385718..39b508bc572c3 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -382,12 +382,25 @@ can generate and submit reports of the given type.  The generations and
 submissions could be done automatically by the kernel or manually by the user,
 depending on the type of the report.
 
-For now, no report type is supported.
+Below report types are supported.
+
+- ``user_report``: User-provided report.  To use this, the user should set the
+  address range of the memory to report for.  This type of report is not
+  automatically generated and submitted to DAMON.  The user should manually
+  generate and submit each report using the interface.
 
 The data attribute probe supports the reports.  The probes can be configured to
 hit for a given memory region if a specific type of valid reports that are
 associated with the probing memory exist in the reports queue.
 
+For example, users can run DAMON in the classical page table accessed bits
+based access monitoring.  In addition to that, users could find hot data that
+might not be able to found by DAMON.  DAMON might not able to find that due to
+limitations in page table accessed bits or its overhead control mechanism.
+Users may be able to find that using their access to workload source code,
+experiment results or other tools.  Users can complement monitoring results by
+feeding the information as user reports.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3

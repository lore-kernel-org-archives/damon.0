Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534624;
	b=VTvfcAO6yRchWx4Aii/2CjCEux9VBR7B/vQHGDKPbC/ayePAqLJ0TM2Tws4CWwkBeK5s
	 aZq56Eiflo24rO3n82XWTGGSTIjMVfKuB71a5npcE64WUeMyq8S7SQtC8UbkZo5lzNe2E
	 HUnr+pQA2a1kOq+TvCbRtP+leadUe4LA2E8Xztc2ICYJnrW7j/jwBdNZtiYlTlpH13U7u
	 MBWkQ+C10kNQXs7fSEQeUSZUDVa3NAubBbY1O+JxEvPGb2NEGSruHnBURoPsKnmQhp3zD
	 /7bbNIAhINJ3eYXOkiHMoGz44TgM2vPNCzu7o4WBsfI+FEu1rScnX2F8bjsWL3jzTxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UIrOYaN831vgERKHpIKG7bVf0L3TmYP5F9joS+wiBOM=;
	b=QWEPleZzQoz1IHjW0z34RdwM1+A+kNv/bx2UyWP27jQ7BIK/iT+mIZC7gcnIFav/sGjp
	 3HHisGeORaoY5i9Xc6p086/yMTMkSXpcurxIK8hwE+xyVpPPVfOkpYpiOE5UKwyQbl1ST
	 WASRNN9paaQB7EXNEgXvBO9Of+7ftXLOIJXDTOQ+EIO9O2Mq0+J/tMIOpZXvVIcDE1327
	 91DfEuLYUOphABXW0E75DkN/9QhazeYk8/GPMgdK/pBtVmLXnqzo7NL3nK0IZrobcHDVx
	 D8uJHhRBhkf8awqdkgIVybJB0V/AYkG45lDtfbZNXueGJ9AmuJzyPaILxw3FpumY+VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeaOvVzd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA78606A31E;
	Tue, 24 Nov 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeaOvVzd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076A91F000D4;
	Tue, 24 Nov 2026 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534624;
	bh=UIrOYaN831vgERKHpIKG7bVf0L3TmYP5F9joS+wiBOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeaOvVzdF59h3OQyemoFqvqD/BvYlAIHW9aEGxsJ6iCiMxky4JlfhLAVH/67MMp9z
	 nMw3WDvm9RGYkJ+0ViLSZ9PDsnzPgNs83NzR2gjxlvAh29GwSvf+MuhZuUZucspHIt
	 xhNGKYWBroM/Y/8C7cLGNycidsBMQqNinOowUwdGQY5lTOaPjWVFFsN0Ur5hiYpadt
	 4MHRydvjU/ubN8ychIoWCyalRzUXtbfaiYiXmOP4bp96bOTEIWFAp+gxL3BSx/bBgZ
	 /ynMlHH5PziG2i7DLjl+Sr/TEPUbPXf/+FvZ9zKF4kSy/bZQ1cb9Ejpbml92kmaEqy
	 DMA3oZLXyE90w==
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
Subject: [PATCH v2 25/27] Docs/mm/damon/design: update for user report support
Date: Tue, 24 Nov 2026 07:36:31 -0800
Message-ID: <20261124153636.91854-26-sj@kernel.org>
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
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly aded user_report type data
attribute reports.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Reviewed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 7ead5716d0c30..70baeef7ec916 100644
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

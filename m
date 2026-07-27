Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA453FA5DD;
	Mon, 27 Jul 2026 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163119; cv=none; b=mFgBa/haP5XxcDJ5jHdDA7aP3I62fouBlHUAA0NUhAjsB9Y+HXCkiymIS1W3qoodZjvFA1Z97CRV4NhoM++ecu/tJ7Bv8b8F2CGwKntFypwa46xO5pe7OmcOQUCtq0h8qFC1gWJZkr6FZnwDsCOned5u6QRqa5kcqJkyJ6eGAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163119; c=relaxed/simple;
	bh=xcWvcxTShuREolgVeaNKxOb9JPpBPwIcsH+2uXlYsDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpR3IMNeTh0DupqjHqy5esVOKB93uxfp4ezyzg9aSuwhgYN259K5Xtl8LWuTW7Hg66CCxLY1Rb439Uym3ptGKDWvyImRCJHAEP9YGjn+oPi9++9F4nWTls4Gcdxw2sOmt8RIlGrsnALyxNalXYQxuFKnehk6TqMDw+6rOwvFe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnSiVQ5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnSiVQ5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEA81F01558;
	Mon, 27 Jul 2026 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163118;
	bh=W5EHzuEPBttna1pHulKblhjSxz0ZvxjVFhC8U+crJAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnSiVQ5g/mNxfLmO3bUJMLGJjREn1gY+MeN8PYhhpiI2mpFuQA6M/2xQucHbcCaBZ
	 pj5WiIlj4QbDagOg1AyfyDTZcewQ4p8eJJWFoh6/R7jpqYeLW77blMyLX74pTTu9pM
	 EQpMA5CuW0sSkk0PQbN2xzHcFmGafS6RZbFa2w29Yf4LFvTyYrIY1OnJ00GVE1qJ4n
	 XBfcGFwgDanMigiz075B7kM/ZKrpF1KTcMkQMB+ncFes45U1pLeBSgoYRYOcbRs/ZW
	 HiYVpqh7Ta9S/GiSfwqg0l2H/UNkUuyMACg4EHCasgVuDXvZobnJOgIvJNGzeLh82K
	 fbn57vFYpyDgg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 15/17] Docs/mm/damon/design: document probe preps
Date: Mon, 27 Jul 2026 07:38:24 -0700
Message-ID: <20260727143829.86236-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON design document for the newly added DAMON probe preps
feature.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index c4830bd09498d..7f983e0c39b80 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -309,6 +309,13 @@ Users can therefore know how much of a given DAMON region has a specific data
 attribute by reading the per-region per-probe probe hits counter after each
 aggregation interval.
 
+Users can optionally register probing preparation actions per probe.  If such
+actions are registered, DAMON applies the actions to each region's sampling
+memory before starting the next sampling interval.  Currently only one action,
+``set_pgidle`` is supported.  The action marks the page for the probing target
+memory as access-idle.  This can be useful to be used together with
+``pgidle_unset`` probe filter.
+
 This is a sampling based mechanism.  Hence, it is lightweight but the output
 may include some measurement errors.  The output should be used with good
 understanding of statistics.
-- 
2.47.3

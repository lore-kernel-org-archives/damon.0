Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968558;
	b=GJr0qzrBYKBbEf/F2t1HiK+WpxkJLRWGb8bj7lZYsJmrnjYxLK+Ex2dI03K2y50gtqyX
	 h9uBlKjf0mboorTibh54fYcutoL5oN2aBZqR8KMRE3rhZJ2dTRhwSvqH5fycyIx0wW11n
	 jy4hT39dwruX/tsYBuWbbWbZhtHpPBNYMLIyzhHV+07h4FHkPwvl2zKUtvmJSFpn9i25T
	 DONd1V/BNlACH/MqIR8Ljv81Q0EF88W7olPyaJyTxKOl8NJzDi1OYs8EtT0oJ8YhB09QZ
	 /m08W44SqLxgxKY7t8EIzY49M54oyZToqdVb2jQgwwyDEl9jZ+FMl2gDE/bfM5Tt7mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968558;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xhM0wpvk6HrSV8qT7cTup9dT9Z84UAe+LdIPivh0Pb8=;
	b=kXwOYEe+w/qu+wG6KStYz1A/msMyxniuDwlQDS5YMB2/0Mh5Ec7n1MIq1jun3Wzm7dSw
	 4rGTrgPf8oOp6pT9Kw/x1wX+ZxFMMySEa2XILeJ+qw60r4EJAoB4KY+0XoEdtpZBG31IJ
	 AVlH9IWMlBC8Cp7x449i2i0ldQN6rTzyNrf7MsfFd63LkkNUy/s/ERnVOqMBK7368wZC5
	 7uKAamTmWepQzTxXhs5/DoTg4aomYb9kuH1SRfjFzMn/IlwYjNu3ixcCPEBJnZnqR60Cw
	 CoykUulx/me4y2PCCMdBPzDLapE8bykDeqgT4U8U/wsleCYyS0VIK/jdPqjf5qDj+7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IUbRBr/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73250606A89F;
	Wed, 18 Nov 2026 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IUbRBr/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1204E1F00937;
	Wed, 18 Nov 2026 02:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968558;
	bh=xhM0wpvk6HrSV8qT7cTup9dT9Z84UAe+LdIPivh0Pb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IUbRBr/XV2gsZZvAvde7FgDlNEltzdLuUysM61B3vw1NR4ukUsoVQjsIFw5Hfvgt3
	 kBdZSY79+CxXBvBxnHLYqgFyF51ijM/5FXQ6Bpj0+wve0oiBJM6YVOhXI8xBHIFQZq
	 b6UY0QvXihgylGdkBh7myElKW/bz7af9klHgEFvY/vZDCgkoGS/celJkgi8c/gKgC3
	 OKk5NAOtOn7hqBDB74iSYVVQFr01tFpANqVGqCiO6smjnaM0i65Lj+oN7ws5Zapfap
	 4O9woMI7t7fOEaAg4mHu+DSvvM7cdSbgKzlaK76C+RRQxjtRItCtWiAjQyc3rk/tI4
	 eJW6qntWmmP+w==
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
Subject: [RFC PATCH v2 17/27] Docs/mm/damon/design: update for report_made probe filter type
Date: Tue, 17 Nov 2026 18:22:12 -0800
Message-ID: <20261118022225.100659-18-sj@kernel.org>
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

Update DAMON design document for the newly added data attribute report
existence type probe filter.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 5a75a69021a48..31ca623385718 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -303,6 +303,8 @@ supported filter types.  Currently below filter types are supported.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
 - ``active``: Same as that for DAMOS filters.
+- ``report_made``: Matches if a :ref:`report <damon_design_attr_reporting>` for
+  the memory is made in last sampling interval.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
@@ -382,6 +384,10 @@ depending on the type of the report.
 
 For now, no report type is supported.
 
+The data attribute probe supports the reports.  The probes can be configured to
+hit for a given memory region if a specific type of valid reports that are
+associated with the probing memory exist in the reports queue.
+
 Dynamic Target Space Updates Handling
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.47.3

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774551;
	b=dPW8n9Ish9t1DQ2FVg/TpIWdqKJBT3SP+fu9OoJm2e49XuNpSxaQ8n244TobtN1lpxFU
	 YPKLeCg+UrGIi9oxf9ldJeT8TLgVTnj8AubOfnyvxC6bFBNQUTG80AdsoMidZVAnZ0J3I
	 +TIEfYKofKT362m4eNQjgJvwTcdrxTEXHpeFIbzcezJSDfmeQ/pD4QhafHOXAmjEVmFHs
	 QOFg97nRALvaZxXFiAQjTU5ATwqXPd9XV5sprvUMJQqBvRDAbK4w7oJffUrhHjCOmMIDU
	 0GbGnc+8EbCldoTfFKZBhhdjm9IBySrxTjUfM/F1rCPEzYhd+Bl3cuY7tbXSsTsRU1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R78z6DX4Eb7n5m3aMS1vuBN9kYcpNJhnmoRj2a8fkoA=;
	b=Wf8OFnH1WooNAUlb06HUSVQUdnvJsWWjCZz/JDxtkg6wRg4qXjSONV+f6R/J5loqJyqg
	 pu1rFyhI4YeHxdroDSYd/My7bSwZg3XiPMRwVk7nrtoyTPBdP5FDRyp0ijvKhpnVnAzAB
	 56IZTTIUHBFIZyZ3J1zbnlupCYEh0X6NhXZImQ46GTM6+6keB9ZTemDi1+yh2y2wjZLuq
	 9KIroie+Xz87pfnAz9ckc4CO5lJ78VI90okP3JCSOFXRvHUruuwIaXjTlvQT6Se+n03A1
	 M0Knj4fm3PuqYzC+QgBydhTp/fmw1UgYgPavQgL0ftsT4GhDEeyeiEkjnvVHVaf62AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTjLMC62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3260A6F77;
	Sun, 15 Nov 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTjLMC62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A121F000C7;
	Sun, 15 Nov 2026 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774551;
	bh=R78z6DX4Eb7n5m3aMS1vuBN9kYcpNJhnmoRj2a8fkoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DTjLMC621hUn/Ztl5qDfxHhBXSLZo3EXqZwM98+Ca6O3K0Mz2eR6WJDssEdG5oNwt
	 nYvY3YlnE3xz+kSl36+d3UaEjqv4gz4ZxONiyWNmFzljzLX9h6kgWdGh0GpNkTO4wI
	 d3mu6f+pQ2kC3nIQ/XcDOsdB7K0RD12s6DHeHZdxEDXXlZV1mjarguB93sRS0khyEV
	 jrVzJQc6Ym7KBYYUpt20dL40CWAawxxanzBhRonB2KHLlUX1jg58fPalptkPQxhKX+
	 iYdw4QMeNVuukoIvy+PFI5nEV3Ia9UYr5GFE8z1H4ZSaM2qofMuo03WNLitvpgIAfw
	 8RSFH/HbgOeyQ==
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
Subject: [RFC PATCH 26/27] Docs/admin-guide/mm/damon/usage: update for user_report report support
Date: Sun, 15 Nov 2026 12:28:44 -0800
Message-ID: <20261115202849.99134-27-sj@kernel.org>
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

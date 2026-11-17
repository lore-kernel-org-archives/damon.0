Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882592;
	b=PWLERvVOmoP+q7uKCYIt4pEkeaLd+3f2RA0b9gMTEOtXEaFagA/1V/Bc9IFUeDkuBnLU
	 POUMfClA0CZWDghMI0uJXeN3trxN9wBftEHghDceF/Ktkjwgudii9QQpxWOBcjQMO8QMZ
	 YRksbDW2y7YEMrIw1hmCnChvYJgcU+PmU0xmFVfCGiV3yxQXI/Y9ReolWnlDaA1V7YBVz
	 /vPYugHNoQ9jhDowvW7Hp9aREfwPc02f/rzBC+65qaAeEvFLBNX4oUF+p4cf4XaTAmAla
	 BrrkCJ4TXFt3Sxm2UaKQpYwRYf5Q/oUnFiVxbkD9dVmrqjEsEdq8HQe2/WCKp1KIzig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=I1NnY1aUEnyj0N2YV2VpV/7pu0yFFtNIfVI4q/uNQmk=;
	b=ZRw2flp0b9pC2nFDFY23BLVslxxHIELklCydHKrMWUkjvW9ZBjVY3wRJ0RcwzBd2g26B
	 OV8LqA0GkA2x6tZhqYQyMf0IJKC86jGuYYWey/e4LkD1WMVujuAaB8DJTFylx37sLH2AK
	 aW2wzNCELst/pAg72Rrp8khA22rwSxHPcyneBrFH+mhDSBCDu0o5EabIh1u1KrogSJIdo
	 LaL3I/fk/uZsFCWwU8dNoz6W6O3j+tTKWo753Sg0Lp07twbXLZgJbaqZx1C/1P/MhEb/G
	 7OxShrwzi7AgNSQmWYNnHwvZb2Q9KL2P86fXb7HiV0+5qVToS7eLx2N/dBB5Q//zPKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvGEZzEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC06606A330;
	Tue, 17 Nov 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TvGEZzEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4771F000C4;
	Tue, 17 Nov 2026 02:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794882592;
	bh=I1NnY1aUEnyj0N2YV2VpV/7pu0yFFtNIfVI4q/uNQmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TvGEZzEHU+YK7myU8eG1QIV0P3CPEqijBPwbgCoeq+/r77R9DFec4r9ST/FRdfWlv
	 YR50U7jG2ZOfEnrjP/ZJLCxAn7LevmeUv4oDlhu7ULa5GdRl1KrQ1ZQhZNXuPl8oDQ
	 LbJD9tX2nTmkRwP8PKKth6dC9/X+oFsaoH+R6qNm6UlYxWp5Ejk7OQiOAGDwGiddi3
	 PP49WS4fIBgufNuEXlrgQjZ62TL/kZNZwEWxovVvquKTaN8IrNtWkTvZD9V9OiXbrU
	 UKcHw9pzKHCDWwpjnhuxhJdP42rv+j48F2eHTBIJs9r04Z09tIB2pRUIbSIIQQFPyj
	 nDbp5EpwAm8RA==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH 5/6] Docs/admin-guide/mm/damon/usage: update for sz_ops_filter_passed_last
Date: Mon, 16 Nov 2026 18:29:43 -0800
Message-ID: <20261117022945.110648-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116-damon-sz-ops-b4-v1-5-1cffe7227e6d@uber.com>
References: 
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

On Mon, 16 Nov 2026 19:10:08 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Update DAMON usage document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
> ---
>  Documentation/admin-guide/mm/damon/usage.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
> index 6093b1c8fbfd..c0101a68a033 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst
> @@ -105,7 +105,7 @@ comma (",").
>      │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
>      │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
>      │ │ │ │ │ │ │ │ 0/id,weight
> -    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots,max_nr_snapshots
> +    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,sz_ops_filter_passed_last,qt_exceeds,nr_snapshots,max_nr_snapshots

Too long line.  Could we wrap the line together?  E.g.,

'''
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -108,7 +108,10 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,sz_ops_filter_passed_last,qt_exceeds,nr_snapshots,max_nr_snapshots
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,
+    │ │ │ │ │ │ │     nr_applied,sz_applied,sz_ops_filter_passed,
+    │ │ │ │ │ │ │     sz_ops_filter_passed_last,qt_exceeds,nr_snapshots,
+    │ │ │ │ │ │ │     max_nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ │ probes
'''

Other than this,

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

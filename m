Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B593D9DDB;
	Tue, 30 Jun 2026 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795184; cv=none; b=UwvrJXZh4syt46Bq7QzX/cvxKQ5JFWwhxGVb64q4blNCu7YpL/qWXnFD2zkaMPMvUnTlCmwsMdQB5Wab4K+qLZJAHlZDDH1BU8w5dk7QMiZQh4f7BQiyXSzIe/Dfd2G0tfDkVn2XypxIFLC/C8mbP2UboeE2X9xgsNQGa2dZx5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795184; c=relaxed/simple;
	bh=ZmfPqVyy0+5l/noH213imKLHMmVu72bmfBvTvCBKBw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNDmaB8TnyuJlsxojIBczi55Atmq9KpYawzMwprRx3+ibA1Od+8VBodn0cERq/6Dcr5v/br4iJXsDraQrRExTtJCVOo897A2z/W69ioPK/jpyaovaOddHV0IdDbFaGMRsnD6fVMwp2ubUNcmj56xiYk5/qkSoU/BpHgLs2ahUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7IKbSNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7IKbSNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06871F000E9;
	Tue, 30 Jun 2026 04:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782795183;
	bh=IRlGgaXw16xjpf66bv4K2Iaac3zOrbbgMuETGo6XHPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7IKbSNcE2lINdb5e83fU8zEFYINgOMzcqLv8dKyDmhIL6cI+MJnLZzTIbwkS8nB7
	 bdOBqyaPuD1vmUgg3YPeYx6i9RGW/RLP+vkbiDKcRCn/53YwK3joAhg+r0qQMh+UfZ
	 PbJGIjCE8M02HNTmrBJH3Nzzvl/hAaDQhKriC3GwRUgs0sdpU4Ygkz1icv6432Ui6g
	 f/WPHcaPOSjq3xrFjDflsyd7VqH71sHLepRdiP9uf97ita08y0gL9Mres7DDWBH1WC
	 /tal0Q1ppmov0ynQFZ+obmVWx2NOGQN+mgyJX3b+UOeg2m9MAPiBerrXp4fJ14Svbf
	 +Tr46LXADli4w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/18] mm/damon: optimize out nr_accesses_bp
Date: Mon, 29 Jun 2026 21:52:53 -0700
Message-ID: <20260630045253.152505-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 21:07:53 -0700 SJ Park <sj@kernel.org> wrote:

> TLDR: Replace damon_region->nr_accesses_bp, which is easy to be wrong,
> with a simpler on-demand moving sum function, damon_nr_accesses_mvsum().

Sashiko found no blocker for this series.  All Sashiko findings and my
responses can be found from the complete thread [1] at lore.kernel.org.

It found a typo in the commit message of patch 14, though.  I added the detail
about the typo as a reply [2] to the patch.  Andrew, could you please fix the
commit message when you pick it up?  If you prefer sending a new revision with
the fixup, pleae feel free to let me know.

[1] https://lore.kernel.org/20260630040812.149729-1-sj@kernel.org
[2] https://lore.kernel.org/20260630044859.152347-1-sj@kernel.org/

Thanks,
SJ

[...]

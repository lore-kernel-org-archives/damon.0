Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF970838
	for <damon@lists.linux.dev>; Mon,  4 Aug 2025 02:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275685; cv=none; b=PFtUAriV0tR5OhIV2lICa/jRRtW1PY5Es3/qcEVhSj7KbVtRmlMM9wTVMZ7voKkXF79I8pFe6BMi7PA2yk/5wg/HMUz9I6TSmi5W/K0FhKZRiPWMa3SI5NvbIH8PV5erl821TlMjpf9hJUlNaSGePoQCGTHZVOtvtrUqjinTHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275685; c=relaxed/simple;
	bh=a9zfeW2WB7bbrMuij4TAEwvYwmIdapst4CP9CUDMag8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFml55iObDbxZZ3w2h8DM9OE3WWipHosU/qxgvZJYomNvknM7tDEFrm664AgfifSZzDWWq8fbkx4Pqu+sn4OOLS3OiZn8GyAUt/5m8oAnS2kIV2QH9nJgRbbnxc7MHa8l04LR3n0f99IasLbBnMW1M7bg/sw13yo3V84Dk3xTZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OJ1SV3F+; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OJ1SV3F+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1754275683; x=1785811683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RKicLz6qk2kkguAEni1vOqzECVIHBfHvbbyhd4kVsDM=;
  b=OJ1SV3F+dMH7aOHcep0SDiyRGzONOi4VuOc5TjCA6uBC4DCsvBTVZ9kK
   zt863fiSDKdl7FaRcp7wGoMer9QrhIzaqOzGNheS+ug/o5lxuIeqXc1Yx
   uQyZQ3guORQIWZsFn2F5g6w0wtTx/pmBXv+ble6kQH8Sg9OqlokfIuBNn
   SA9QloCx2a3X/eg965mVoGbFnVqoTovldrKSHkquzJSTnvbBQT/ZOw/3K
   g5zM8pF3BAcnDD8QL+Sk+B9Os9vUUJj7Bkrq9iKNiz3CBBLqGg3CMNaYv
   wEfPv3fgnbP/ar4Z5u3N0MMBvoZrCEhCVgMPoivnSYgAaF5BSmAv64Qaa
   A==;
X-CSE-ConnectionGUID: cCd3RQGgQoqlNkLrBO2LSg==
X-CSE-MsgGUID: VlhjKe74QCGXeEHunRLy/A==
X-IronPort-AV: E=Sophos;i="6.17,258,1747699200"; 
   d="scan'208";a="414218"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-west-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 02:47:53 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.10.100:10198]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.198:2525] with esmtp (Farcaster)
 id df118047-9890-4fac-bbc9-48f9ecc15387; Mon, 4 Aug 2025 02:47:53 +0000 (UTC)
X-Farcaster-Flow-ID: df118047-9890-4fac-bbc9-48f9ecc15387
Received: from EX19D026EUB004.ant.amazon.com (10.252.61.64) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 4 Aug 2025 02:47:52 +0000
Received: from 3c06303d853a (10.187.171.18) by EX19D026EUB004.ant.amazon.com
 (10.252.61.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 4 Aug 2025
 02:47:49 +0000
Date: Sun, 3 Aug 2025 19:47:41 -0700
From: Andrew Paniakin <apanyaki@amazon.com>
To: SeongJae Park <sj@kernel.org>
CC: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Jann Horn
	<jannh@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Michal
 Hocko" <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Pedro Falcato
	<pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
	<vbabka@suse.cz>, <damon@lists.linux.dev>, <kernel-team@meta.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<amazon-linux-kernel@amazon.com>
Subject: Re: [RFC v2 0/7] mm/damon: extend for page faults reporting based
 access monitoring
Message-ID: <aJAfTUh-49pYuhbg@3c06303d853a>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D026EUB004.ant.amazon.com (10.252.61.64)

On 27/07/2025, SeongJae Park wrote:
> TL; DR: Extend DAMON interface between core and operation sets for
> operation set driven report-based monitoring such as per-CPU and
> write-only access monitoring.  Further introduce an example physical
> address space monitoring operation set that uses page faults as the
> source of the information.

Thank you very much for starting this update. RFC mentions write-only
monitoring, this feature particularly would be really helpful in some of
our use cases such as lightweight live migration target selection, so we
are looking forward to collaborate in development and testing activity!

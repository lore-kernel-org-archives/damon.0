Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF514F112;
	Thu, 16 Oct 2025 20:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645569; cv=none; b=Wc3sy6pDIGBL12oikoeX9oNWbYbUTBkXAKqkAeFnmVC1g4pUx2zT6V3hoZuzKspIVmxHA6PTGATw7u+cY6OFwVum77oj96i3rQ1WvbOw9PQRKBpItLm/OmR6YrdAK3FKEYlEYR65Vm2n9QfBCzQaiYTKdlE3pnkc8j5seWHZixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645569; c=relaxed/simple;
	bh=hGHCpwHFjhYGBlIJ4lsr7K362zIchdafnBRS9eORujA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bsu9L6tSRPteryC5Y6KyJNIxxnLLNPF/CK+Z4XXVsRFnvWh73gJNYQ+ZDQ9lfKPuCn+9O5XUV6s5uSTYFvsn2YnxHz02zMrABOMTzJxPdwmmRw6pHZQkNmkd4JcQUJonjyrkkIIFUche/RwK/jWKwZZRREdo7Jq4yam22OZc3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZdKC9d/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZdKC9d/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B59C4CEF1;
	Thu, 16 Oct 2025 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760645569;
	bh=hGHCpwHFjhYGBlIJ4lsr7K362zIchdafnBRS9eORujA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdKC9d/btE1m0xZ61lYAg+wlDWdGL+D47uYKRg0/eTHT5+VKAzP8q/qz1g3o1swd5
	 FYAIYSVeAP7F8O1fF+PscAwDhRwuGjUMw/eGo+mUHD3i4wCIzAI1KxB4hvBEJUiapI
	 325YCNf2UGVQWbY9UxfDT+g8j4rFQ1yxEXUr4zNk=
Date: Thu, 16 Oct 2025 13:12:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: <sj@kernel.org>, <damon@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
Subject: Re: [PATCH] mm/damon: add a min_sz_region parameter to
 damon_set_region_biggest_system_ram_default()
Message-Id: <20251016131248.f74041dd236ca33808a07ba4@linux-foundation.org>
In-Reply-To: <20251016104717.2194909-1-yanquanmin1@huawei.com>
References: <20251016104717.2194909-1-yanquanmin1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 18:47:17 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> After adding addr_unit support for DAMON_LRU_SORT and DAMON_RECLAIM,
> the related region setup now requires alignment based on min_sz_region.

Why?

Presumably the current code causes some sort of user-visible
misbehavior.  Please include a description of that misbehavior and of
how users might trigger it.

> Add min_sz_region to damon_set_region_biggest_system_ram_default()
> and use it when calling damon_set_regions(), replacing the previously
> hardcoded DAMON_MIN_REGION.
> 


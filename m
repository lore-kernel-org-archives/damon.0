Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCC3F9F46
	for <damon@lists.linux.dev>; Wed, 25 Mar 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456146; cv=pass; b=BU9vfpLW5HIHevYmAykndOKzfWKgKrA813kkeQTz4x+FMLcr/uELuRYESkkvsCbGTcW+C/8tkpge3jR1q7B3oHwqC3Wi/TotviqR3On05h77oLpjE06Sb/8qpqRB/1LcJZXwrfou+U3U4yZzn/PV0gnxPdG1hppboXIvHiIq7f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456146; c=relaxed/simple;
	bh=gvcPUunMSnKPiMFhtHMRn/xytFtoCdJ/9tpmY9Te04c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Hzy1YFnqXg9yl7RPRssppF6cnLCno5Js01qIMbNsP1N4751AlsF7Um4CwadEvONdmc3GI5+QDnJAAkvxPJgSnGFY7mIqY8bcpZEwd8ZKxafQrJlsbRHxGdRSo1LxR58Sr9xlHk72lDli4D73ZH6BZS1Abzwjki1NaRAoFShjQ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Q+mnHiIz; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Q+mnHiIz"
ARC-Seal: i=1; a=rsa-sha256; t=1774456141; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=gRsaQRDiy+FmYqh9n3a7FIuikyYTYiHVKE/k8Esol/HJL4rjLIYnazzlJj1jVkcANeODLSkCuTUMbKV4lSBHZOaExZQ/Acz7m7yNWr4VZ7swOGFoZmkZItumamGVph8m15G+1lLwrVCSQHyeZbLUVonXucG16t0TGzWvPjBIi1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774456141; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oeL6ks64Ze/pGwHs2qvXBTZpnyzzF7fV/OGrrVTI+fE=; 
	b=PA/AZNbOoW+DkhM8Kn1+rOBNBhG0IZSP546CuAiA5hoCeqGK0FVNEGWHWioMGAnfzCFLOcDnd3qtcIySIMo12EKEy0//lcvnjTVi9SBfEs0PzULSv6vgHK6Iy7mDHfD+UuslwpGy2EtvRVxrm2pYMPjVcFEdGodFaAByOKDR5Z0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774456141;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=oeL6ks64Ze/pGwHs2qvXBTZpnyzzF7fV/OGrrVTI+fE=;
	b=Q+mnHiIzlSoEzqFyrU/ucAwSjef8B716hAKKXSG/8GaOq5LOaVbGlQqb/DCllA6l
	rXqv+Wpfk088e4oPy4C2dYI+W3YkqgBHp0wu/luNovyRcvGGIwlRLK9osY8oOSC4nIh
	pYZN27RDo/NKdM5R3sQVQ2mvDid+I5H3RSk55RZI=
Received: by mx.zoho.eu with SMTPS id 1774456138981542.036524592639;
	Wed, 25 Mar 2026 17:28:58 +0100 (CET)
Date: Wed, 25 Mar 2026 15:44:46 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: (sashiko status) [PATCH 0/3] mm/damon/core: small cleanups
User-Agent: Thunderbird for Android
In-Reply-To: <20260325145827.88239-1-sj@kernel.org>
References:  <20260325145827.88239-1-sj@kernel.org>
Message-ID: <645AE1AF-0BA6-47C9-9B53-058F21DDB327@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 25 March 2026 14:58:26 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Forwarding sashiko=2Edev review status for this thread=2E
>
># review url: https://sashiko=2Edev/#/patchset/20260325073800=2E141756-1-=
objecting@objecting=2Eorg
>
>- [PATCH 1/3] mm/damon/core: deduplicate scheme index lookup into helper
>  - status: Reviewed
>  - review: No issues found=2E
>- [PATCH 2/3] mm/damon/core: use damon_nr_regions() in damon_commit_targe=
t_regions()
>  - status: Reviewed
>  - review: No issues found=2E
>- [PATCH 3/3] mm/damon/core: move last_nr_regions from static local to da=
mon_ctx
>  - status: Reviewed
>  - review: No issues found=2E
>
># hkml [1] generated a draft of this mail=2E  It can be regenerated
># using below command:
>#
>#     hkml patch sashiko_dev --thread_status --for_forwarding \
>#             20260325073800=2E141756-1-objecting@objecting=2Eorg
>#
># [1] https://github=2Ecom/sjp38/hackermail
>
>Sent using hkml (https://github=2Ecom/sjp38/hackermail)



Yay! No regressions

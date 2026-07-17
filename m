Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53833688D
	for <damon@lists.linux.dev>; Fri, 17 Jul 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278002; cv=none; b=sgvduqIe6PS/TJA1m57N+vP6Q9mZViAAtdandZWqEGf5hJi5MBZz2zh/WyHKDwVV1gPyyv1bXbTm4WP4s7XNK/i/pddsGPyDkFaEVUa3gRketOxRlGHJZqOE+DhU9tnaD54HzsUeLnHYJw7fkmqUvFi/QGgnlZqhoheRYaAi3bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278002; c=relaxed/simple;
	bh=UqcxRs/3llcGhtVeN5y4CTBUamZ1fjpw1dFGJVDDzOc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NwQTwwCG0RKeukKTJi8xv8m0NhwlkUkX01ioTBAslQjVXUvAEs/YykH72Z/C/2xUJMN9i0aY+wBhbytJUagHERvDeW0vc3xdWLuO2ItDFJJIoNh8tUa0r0IhCafEclAOUOWfP3s/3wTQFdtcDzur8plTqOQfLj3BCSzj1iWc5qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 036adba881bc11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3fb38247-c943-4f74-9cf0-1ea30deec863,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:3fb38247-c943-4f74-9cf0-1ea30deec863,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:4c451bc509afd43d951a03b62fcafa9c,BulkI
	D:260716215446VE8XWLNT,BulkQuantity:1,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|127|841|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File
	:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
	:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 036adba881bc11f1aa26b74ffac11d73-20260717
X-User: lienze@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1226684243; Fri, 17 Jul 2026 16:46:33 +0800
From: Enze Li <lienze@kylinos.cn>
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev,  linux-mm@kvack.org,  enze.li@gmx.com
Subject: Re: [PATCH] samples/damon/prcl: add module parameter description
 for target_pid
In-Reply-To: <20260716135438.101815-1-sj@kernel.org>
References: <20260716135438.101815-1-sj@kernel.org>
Date: Fri, 17 Jul 2026 16:46:26 +0800
Message-ID: <875x2ej95p.fsf@kylinos.cn>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi SJ,

Thank you for your review.

On Thu, Jul 16 2026 at 06:54:37 AM -0700, SJ Park wrote:
> Hello Enze,
>
>
> Thank you for this patch!
>
> On Thu, 16 Jul 2026 17:14:44 +0800 Enze Li <lienze@kylinos.cn> wrote:
>
>> Document 'target_pid' via MODULE_PARM_DESC so its meaning is visible
>> through kernel command line usage and sysfs interface.
>
> But...  It is a static module.  Is there a way to read this documentation=
 from
> the user space?  If there is no such a way, I don't really think this cha=
nge is
> needed.  If we want to document this, we could use comments.

AFAIK, MODULE_PARM_DESC() is for loadable modules.  For builtins, it=E2=80=
=99s
effectively just a comment.  That said, if DAMON gains loadable module
support later, having these descriptors in place means we won=E2=80=99t nee=
d to
touch the code. WDYT=EF=BC=9F

Thanks,
Enze

<...>

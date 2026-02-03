Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140329ACF0
	for <damon@lists.linux.dev>; Tue,  3 Feb 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148099; cv=pass; b=EdSyIEcGQ4osLsdFwQH4tRuwGsk/63lIZQnGYCLwhYntCJ4t6XaNAi0VAKHnzm7qdkvwCrIKqReN/M6wQ1baQpor6kxolvcSgm9URF5NT+3kwnwDQex9FWtsxDRw8nOpUP0GGxh6P/i0sGJer80/2eKF9XH8gXalGCqpze8o+AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148099; c=relaxed/simple;
	bh=kNXxiUDQy1SVXfSeJbu09uShQ8mMvmjrjF4sRv0Rx5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHo5yCmIv+Dq+CLrffmqiPW7qpZYTde5+iXZJryEw7teirKQ+/cIRQbsSK/glcuKA4ei2kNCIcjH4A2CfEiw3QmiD77ZonrEmeBdVSSAVeXo06s+XIPUGYn2xAsq34gX/XWjYYkVS8miaDNR3Xi01sg1yklOuwTc86VXbhTHnmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3WXNbOZ; arc=pass smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3WXNbOZ"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-124afd03fd1so9045768c88.0
        for <damon@lists.linux.dev>; Tue, 03 Feb 2026 11:48:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770148098; cv=none;
        d=google.com; s=arc-20240605;
        b=Ck3GF2Q+OmayX6K8w8dI6RzfH/glZE/LiCyX/PG2O0Muqob438eg0jsEP/GTQfmAVa
         uojMEMF8nh/pXc81i3Kvcv94By0s7fFnM19F2j5nIUUuYwVqnrnaprtDj32OpbJJQZmI
         DyWRl/oW52XMXNMn5RxM+ddsLXJW4deaA4J68xavj8cZa8lUEX/PARSbCYCPpvJwFvS1
         AMxc/URcqtIHy2aKnfOthq44n2hN/Q6OByCg7IFLiYpkpAIjJ8ctQz7DULPZaV9Eqd6Z
         rETmBLHyY9dKmsx2kLwaLnbUigBqy9KVZnACJDS4a052f6hrLIylaE7xalEKFrVlICGf
         t3mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ljYXjREKDmOu7d2s7Y3SwTV+aN53dscZlpBmijYsyBA=;
        fh=g3VMvJQux/HSLIVicncr24svuVPzuNK+KAx5AQfJAks=;
        b=GckLEuP+hJr/XzMb2RPUCwsWRxhwCL0dPDEAY1dVUn6h2gaX20rFkhcQ6gpCxnRtyT
         Y3ECHoBt6Bn/tTJ/DNUtoQIbCP/NS1IoG/3NJ9yX7t/4g0ImBS9lrUW5RLMvVu3KUPk1
         qgzCBv2XVNipCsz5v9SwZDIW8+DFJPyH6bZSYZsQxnhT3qrtt7OHevPDGdyTkGINA2f7
         trBgtbBaVdWXu2gUUR7Udub9OfLY1SvE+fSwCMrzmG0PLiXziepXmfiw5hH0mAV4Eq76
         Y+lU6pbEBOaCgowSVUSB/IHGGVAoURC0vy7DYcNe/zmHHmzwXZ1Y7HA+3MjNdjn+1ZsR
         g0VA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770148098; x=1770752898; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljYXjREKDmOu7d2s7Y3SwTV+aN53dscZlpBmijYsyBA=;
        b=I3WXNbOZW6yneGC9mtr4hi/ewl41UzmzWXrEUkAh1GqS2JZaCl7NT74MA7QT8Ysn+j
         yYLAFv5p/zEPxo3Fl5SoT+qGZEqw6eGn2PttB0tpPZDAASOy3kLNDLfUJP/JNOGU3QRJ
         L6ZDbJQekFgw8VW3X6SgeGH/u8nSBi3dOd3lqUsSjCIA6klwsO6/PxM+9QDuBy2fP24/
         mcswDDGqeC+Z+dhP7AH2NnTA1h2EGKK1/kOfhxOp97jAjm19irKZHVw0+89GHcz6allx
         pZHWSovc6UGG3B52hSWldC/NO+YxgpErLbuGS8gR8O1TkxXfY+LLzIPe+KK31Cl9xh4+
         DINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148098; x=1770752898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljYXjREKDmOu7d2s7Y3SwTV+aN53dscZlpBmijYsyBA=;
        b=e0PbuZR8VbmnK/aIBXPCYK2Z6cyANBVx9oesBs01zKws+bxKJMauRptu3lwhetxq1n
         owGApE5osivh6K465D0XrJYLPhywZtffSAlUp0lo9jkVkkcAUKAL1IieMcRG2DkXWiWZ
         WOK+WAWSNfa5Bu49KBKJf9RinhlKnXB3itb9WWJ4qMMfZysXnmac3Q6kWSZ9t6Vt6Uaq
         WnBgTTJp5+07kNNa6XqvKfjGU0gMsyIArbZVfMFGGCexWEafX7kdbH0L9ZcpHc8czJyi
         zrWxz+7DceZvQUREC6E5QNwsPmRLQf/mjfkOtismiESz3IK3x4eAGAjCRTDiJshuhzug
         Iyaw==
X-Gm-Message-State: AOJu0YyaefMPubcbsMCkOl0k96GAss98be0p1KQw0KTcnJlkg4tpx8fS
	WeIPMnk4iZSuAOSjKevNW9Cg9BAjUotkNs/xtpvS/P6xSKZapf7o9AA+iWOjCBWOecxKW63K/hh
	M4TZM9oWnEotEDJf/KyHDAVVs6q3HAg==
X-Gm-Gg: AZuq6aLtRcQmCvIlWzVFpW3Zm+WEW2g28fjyuhFnO1UizhnU3eJf/1vdy6yE7RTSyPP
	ItPIy751gGUZ5MTL5GYZ9CRjTFrUSfzWFBc5nZS7TGshCDpzU9Mo6BbBYef46IoQIsXjByyPsG5
	8noBkwCX0rmFh5L4bsEN+jcqrTk5u1epIu+Qgc4x/RvjWtQsG5mVlspnFeLLid/Pv2RERcmWa9/
	kReQVSJMzRqOVv/FzbqtkvqrzVo1ldcn+DV32HLLJuIyxeRuhkID6EyweZmlcDldUtD5ZQ=
X-Received: by 2002:a05:7022:6ba2:b0:11b:923d:773f with SMTP id
 a92af1059eb24-126f4781428mr242143c88.5.1770148097517; Tue, 03 Feb 2026
 11:48:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260130014807.51302-1-sj@kernel.org> <20260131195408.66514-1-sj@kernel.org>
In-Reply-To: <20260131195408.66514-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Tue, 3 Feb 2026 11:48:06 -0800
X-Gm-Features: AZwV_QhQ9CdPx0t0XZJXip2Lmrp6vOfL-d4v8wYJQjypSaPQbLX41bGGmoxym7c
Message-ID: <CALa+Y1475VSnrNTn-AQtTTnye+sdAGu9sVO0YMEtLidNW53_=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm/damon: Introduce node_target_mem_bp Quota
 Goal Metric
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijan311@gmail.com, ajayjoshi@micron.com, honggyu.kim@sk.com, 
	yunjeong.mun@sk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 31, 2026 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Thu, 29 Jan 2026 17:48:06 -0800 SeongJae Park <sj@kernel.org> wrote:
>
> > On Thu, 29 Jan 2026 13:58:11 -0800 Ravi Jonnalagadda <ravis.opensrc@gma=
il.com> wrote:
> >
> > > This series introduces a new DAMON quota goal metric, `node_target_me=
m_bp`,
> > > designed for controlling memory migration in heterogeneous memory sys=
tems
> > > (e.g., DRAM and CXL memory tiering).
> > >
> > > v1: https://lore.kernel.org/linux-mm/20260123045733.6954-1-ravis.open=
src@gmail.com/T/#u
> [...]
> >     Context 0: monitors node 0, migrate_hot -> node 1
> >       goal: node_ineligible_mem_bp, nid=3D0, target=3D4000
> >
> >     Context 1: monitors node 1, migrate_hot -> node 0
> >       goal: node_target_mem_bp, nid=3D0, target=3D6000
>
> In offline, Ravi enlightened me that using a single context with two sche=
mes
> instead of the above two contexts setup can be more efficienct and useful=
.  I
> agree that.  It will be able to only single kdamond, and there could be m=
ore
> flexible use cases that can use the whole-memory access pattern.
>
> That is, we can use single context with the two schemes, but adding a cor=
e
> layer DAMOS filters for applying the schemes to only memory of node 0 and=
 node
> 1, respectively.  Similar for memory tiering use cases.
>
> But I was recommending the multi contexts approach to people because the
> current implementation of DAMOS is not efficient when both quota and core=
 layer
> filters are used.  I was actually working on making it improved, and just
> posted an RFC patch series [1].  After the patches are merged, hopefully =
the
> single context approach will be useful and effcient enough for varying us=
e
> cases including the memory tiering.
>
> [1] https://lore.kernel.org/20260131194145.66286-1-sj@kernel.org
>
Thanks for providing the DAMOS_FILTER patch update SJ.

For v3, I plan to introduce two complementary metrics:
DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP
and DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP.

This will support the following approaches for hot memory migration:
1. Single context with two schemes using both metrics.
(along with DAMOS_FILTER_TYPE_ADDR)
2. Two DAMON contexts each using
DAMOS_QUOTA_NODE_INELIGIBLE_MEM_BP.

Will provide more details on the implementation and usage in the v3 series.

Thanks,
Ravi.
>
> Thanks,
> SJ
>
> [...]
